//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import RepresentationKit

struct Book {
    let name: String
    let edition: String
}

extension Book: Representable {
    func represent(using representation: Representation) -> Representation {
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

let books = (0..<2).map { Book(name: "Book \($0)", edition: "Edition \($0)") }
print("Books = \(books)")

let arrayRep = ArrayRepresentationBuilder()
let dictRep = DictionaryRepresentationBuilder()

let arrayResuslt: ArrayRepresentationBuilder = books[0].represent(using: arrayRep)
print(arrayResuslt.array)

let dictResuslt: DictionaryRepresentation = books[0].represent(using: dictRep)
print(dictResuslt.dictionary)

let dictionaryRepresentationOfAnArray: DictionaryRepresentation = books.represent(using: dictRep)
print(dictionaryRepresentationOfAnArray.dictionary)

let deepRep = DeepArrayRepresentationBuilder(representation: JSONRepresentationBuilder())
let deepRepRes: DeepArrayRepresentationBuilder = books.represent(using: deepRep)
print(deepRepRes.array.map { $0.dictionary })


//
//let typedArrayRep = TypedArrayRepresentationBuilder<String>()
//let a: TypedArrayRepresentationBuilder<String> = books[0].represent(using: typedArrayRep)
//print(a.array)

//let typedArrayRep = TypedArrayRepresentationBuilder<String>()
//let a: TypedArrayRepresentationBuilder<String> = books[0].represent(using: typedArrayRep)
//let arR: DictionaryRepresentation = a.represent(using: dictRep)
//print(arR.dictionary)

//let enume2: ArrayRepresentationBuilder = books.represent(using: arrayRep)
//print(enume2.array)


//let deepArrayRep = DeepArrayRepresentationBuilder(representation: TypedArrayRepresentationBuilder<String>())
//let deepArrayRepRes: DeepArrayRepresentationBuilder = books.represent(using: deepArrayRep)
//print(deepArrayRepRes.array.map { $0.array })

//let d = ["first" : "John", "last" : "Smith"]
//let arrR: ArrayRepresentationBuilder = d.represent(using: arrayRep)
//print(arrR.array)
