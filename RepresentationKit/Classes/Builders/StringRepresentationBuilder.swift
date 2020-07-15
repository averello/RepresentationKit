//
//  StringRepresentationBuilder.swift
//  Pods
//
//  Created by Georges Boumis on 27/4/20.
//

import Foundation

public protocol StringRepresentation: Representation, Representable {

    var string: String { get }
}

extension StringRepresentation {

    public func represent<R>(using representation: R) -> R where R : Representation {
        return representation
            .with(key: "StringRepresentation", value: self.string)
    }
}

public struct StringRepresentationBuilder: StringRepresentation {
    public let string: String
    public let separator: String

    public init(separator: String) {
        self.init("", separator: separator)
    }

    private init(_ string: String, separator: String) {
        self.string = string
        self.separator = separator
    }

    public func with<Key, Value>(key: Key, value: Value) -> Representation where Key : Hashable, Key : LosslessStringConvertible {
        return StringRepresentationBuilder(self.string + self.separator +  String(describing: value), separator: self.separator)
    }

    public func represent<R>(using representation: R) -> R where R : Representation {
        return representation
            .with(key: "SstringRepresentationBuilder", value: self.string)
    }
}
