# RepresentationKit

RepresentationKit permits objects to represent themselves through key-values to
arbitrary representations. Thus objects become `Representable`. [As getters and
setters are
evil](https://www.yegor256.com/2014/09/16/getters-and-setters-are-evil.html)
RepresentationKit avoids being interrogated/queried by a "dumper" object.
Instead a `Representation` that can be passed to an object that will
describe/represent itself upon it. `Representation`s trust objects to not lie
about what information will they expose and thus respect them.

Influenced by [Printers instead of
getters](http://www.yegor256.com/2016/04/05/printers-instead-of-getters.html).

## Example

To run the example project, clone the repo, and run `pod install` from the
Example directory first.

## Code Example

```swift
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

// some books
let books = (0..<2).map { Book(name: "Book \($0)", edition: "Edition \($0)") }
print("Books = \(books)")
// Prints "Books = [Book(Book 0,Edition 0), Book(Book 1,Edition 1)]"

let arrayRep = ArrayRepresentationBuilder()
let dictRep = DictionaryRepresentationBuilder()

// represent a book as an array
let arrayResult: ArrayRepresentationBuilder = books[0].represent(using: arrayRep)
print(arrayResult.array)
// Prints ["Book 0", "Edition 0"]

// represent a book as dictionary
let dictResuslt: DictionaryRepresentation = books[0].represent(using: dictRep)
print(dictResuslt.dictionary)
// Prints ["name": "Book 0", "edition": "Edition 0"]

// represent an array of books
let dictionaryRepresentationOfAnArray: DictionaryRepresentation = books.represent(using: dictRep)
print(dictionaryRepresentationOfAnArray.dictionary)
// Prints ["0": Book(Book 0,Edition 0), "1": Book(Book 1,Edition 1)]

// let's get crazy
let deepRep = DeepArrayRepresentationBuilder(representation: JSONRepresentationBuilder())
let deepRepRes: DeepArrayRepresentationBuilder = books.represent(using: deepRep)
print(deepRepRes.array.map { $0.dictionary })
// Prints [["name": "Book 0", "edition": "Edition 0"], ["name": "Book 1", "edition": "Edition 1"]]
```

## Installation

RepresentationKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "RepresentationKit"
```

## Author

Georges Boumis, developer.george.boumis@gmail.com

## License

RepresentationKit is available under the Apache 2.0 license. See the LICENSE
file for more info.
