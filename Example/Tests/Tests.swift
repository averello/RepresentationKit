import XCTest
import RepresentationKit

struct Book {
    let name: String
    let edition: String
}

struct Editor {
    let name: String
    var books: [Book]
}

extension Book: Equatable {}

extension Book: Representable {

    func represent<R>(using representation: R) -> R where R : Representation {
        return representation
            .with(key: "name", value: self.name)
            .with(key: "edition", value: self.edition)
    }
}

extension Book: CustomStringConvertible {

    var description: String {
        return "Book(\(self.name),\(self.edition))"
    }
}

class Tests: XCTestCase {

    let editor = Editor(name: "Fenguin", books: (0..<2).map { Book(name: "Book \($0)", edition: "Edition \($0)") })
    var books: [Book] { self.editor.books }

    func testStringRepresentationOnObject() {
        let representation = books[0].represent(using: StringRepresentationBuilder(separator: ","))
        XCTAssertEqual(representation.string, books[0].description)
    }

    func testArrayRepresentationOnObject() {
        let arrayResult = books[0].represent(using: ArrayRepresentationBuilder())
        let result = arrayResult.array

        XCTAssertEqual(result.count, 2)

        XCTAssertTrue(result[0] is String)
        XCTAssertEqual((result[0] as! String), "Book 0")

        XCTAssertTrue(result[1] is String)
        XCTAssertEqual((result[1] as! String), "Edition 0")
    }

    func testArrayRepresentationOnArray() {
        let arrayRep = ArrayRepresentationBuilder()
        let arrayResult = books.represent(using: arrayRep)
        let result = arrayResult.array

        XCTAssertEqual(result.count, 2)

        XCTAssertTrue(result[0] is [String])
        XCTAssertEqual((result[0] as! [String]), (books[0].represent(using: ArrayRepresentationBuilder()) as ArrayRepresentationBuilder).array as! [String])

        XCTAssertTrue(result[1] is [String])
        XCTAssertEqual((result[1] as! [String]), (books[1].represent(using: ArrayRepresentationBuilder()) as ArrayRepresentationBuilder).array as! [String])
    }

//    func testTypedArrayRepresentationOnObject() {
//        let rep = TypedArrayRepresentationBuilder<String>()
//        let repResult = books[0].represent(using: rep)
//        let result = repResult.array
//
//        XCTAssertEqual(result.count, 2)
//
//        XCTAssertEqual(result[0], "Book 0")
//        XCTAssertEqual(result[1], "Edition 0")
//    }
//
//    func testTypedArrayRepresentationOnArray() {
//        let rep = TypedArrayRepresentationBuilder<String>()
//        let repResult = books.represent(using: rep)
//        let result = repResult.array
//
//        XCTAssertEqual(result.count, 2)
//
//        XCTAssertEqual(result[0], "Book 0")
//        XCTAssertEqual(result[1], "Edition 0")
//    }
//
//    func testDeepArrayRepresentationBuilderOnArray() {
//        let arrayRep = DeepArrayRepresentationBuilder(representation: ArrayRepresentationBuilder())
//        let arrayResult: DeepArrayRepresentationBuilder = books.represent(using: arrayRep)
//        let result = arrayResult.array
//
////        XCTAssertEqual(result.count, 2)
////
////        XCTAssertTrue(result[0] is Book)
////        XCTAssertEqual((result[0] as! Book), books[0])
////
////        XCTAssertTrue(result[1] is Book)
////        XCTAssertEqual((result[1] as! Book), books[1])
//    }
//
////    TypedArrayRepresentation
//
//    func test() {
//        let arrayRep = ArrayRepresentationBuilder()
//        let dictRep = DictionaryRepresentationBuilder()
//
//        // represent a book as an array
//        let arrayResult: ArrayRepresentationBuilder = books[0].represent(using: arrayRep)
//        print(arrayResult.array)
//        // Prints ["Book 0", "Edition 0"]
//
//        // represent a book as dictionary
//        let dictResuslt: DictionaryRepresentation = books[0].represent(using: dictRep)
//        print(dictResuslt.dictionary)
//        // Prints ["name": "Book 0", "edition": "Edition 0"]
//
//        // represent an array of books
//        let dictionaryRepresentationOfAnArray: DictionaryRepresentation = books.represent(using: dictRep)
//        print(dictionaryRepresentationOfAnArray.dictionary)
//        // Prints ["0": Book(Book 0,Edition 0), "1": Book(Book 1,Edition 1)]
//
//        // let's get crazy
//        let deepRep = DeepArrayRepresentationBuilder(representation: JSONRepresentationBuilder())
//        let deepRepRes: DeepArrayRepresentationBuilder = books.represent(using: deepRep)
//        print(deepRepRes.array.map { $0.dictionary })
//        // Prints [["name": "Book 0", "edition": "Edition 0"], ["name": "Book 1", "edition": "Edition 1"]]
//
//    }
}
