//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import RepresentationKit

struct Book {
    let name: String
    let IBAN: UUID
}

extension Book: Representable {
    func represent(using representation: Representation) -> Representation {
        return representation
            .with(key: "name", value: self.name)
            .with(key: "IBAN", value: self.IBAN.uuidString)
    }
}

extension Book: CustomStringConvertible {
    var description: String {
        return "Book(\(self.name),\(self.IBAN.uuidString))"
    }
}

let books = (0..<2).map { Book(name: "Book \($0)", IBAN: UUID()) }
print("Books = \(books)")

let arrayRep = ArrayRepresentationBuilder()
let dictRep = DictionaryRepresentationBuilder()

//let arrayRes: ArrayRepresentationBuilder = books[0].represent(using: arrayRep)
//print(arrayRes.array)

//let dictRes: DictionaryRepresentation = books[0].represent(using: dictRep)
//print(dictRes.dictionary)

//let deepRep = DeepArrayRepresentationBuilder(representation: JSONRepresentationBuilder())
//let deepRepRes: DeepArrayRepresentationBuilder = books.represent(using: deepRep)
//print(deepRepRes.array.map { $0.json })


//let enume: DictionaryRepresentation = books.represent(using: dictRep)
//print(enume.dictionary)
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
