//
//  TypedArrayRepresentation.swift
//  Pods
//
//  Created by Georges Boumis on 20/08/2017.
//
//

import Foundation

/// Describes an array representation. Also the conforming class can be
/// represented itself.
///
///     struct Book: Representable {
///       let name: String
///       let edition: String
///
///       func represent(using representation: Representation) -> Representation {
///           return representation
///               .with(key: "name", value: self.name)
///               .with(key: "edition", value: self.edition)
///       }
///     }
///
///     let book = Book(name: "Super title", edition: "Pepper's")
///
///     var representation: TypedArrayRepresentation = /* TypedArrayRepresentationImpl<String> */
///     representation = book.represent(using: representation)
///
///     print(representation.array) // here representation.array is a [String]
///     // Prints ["Super title", "Pepper's"]
///
/// - SeeAlso: `ArrayRepresentation`
public protocol TypedArrayRepresentation: Representation, Representable {
    associatedtype Element
    
    /// the typed array of the represented values.
    var array: [Element] { get }
}

public extension TypedArrayRepresentation {
    
    public func represent<Rep>(using representation: Rep) -> Rep where Rep: Representation {
        var r = representation
        
        for (index,element) in self.array.enumerated() {
            r = r.with(key: "\(index)", value: element) as! Rep
        }
        return r
    }
}
