import UIKit

//"Handling missing data"
var age: Int? = nil
age = 38

//"Unwrapping optionals"
var name: String? = nil

if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name") //"Missing name"
}

//"Unwrapping with guard"
func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }
    
    print("Hello, \(unwrapped)!)")
}

greet(name) //"You didn't provide a name!"

//"Force unwrapping"
let string1 = "5"
let number = Int(string1)! //5

let string2 = "Fish"
let optionalNumber = Int(string1) //Int?
//let forceUnwrappedNumber = optionalNumber! //crash!

//"Implicitly unwrapped optionals"
let height: Int! = nil //Use sparingly

//"Nil coalescing"
func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}

let user = username(for: 15) ?? "Anonymous" //"Anonymous"

//"Optional chaining"
let names = ["John", "Paul", "George", "Ringo"]
let beatle = names.first?.uppercased()

//"Optional try"
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
} //"You can't use that password."

if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh!")
}

try! checkPassword("sekrit") //Only if you know it's safe

//"Failable initialisers"
struct Person {
    var id: String

    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}

if let person = Person(id: "9") {
    print("Person with id \(person.id) was created.")
} else {
    print("Couldn't create a person.")
} //"Couldn't create a person."

//"Typecasting"
class Animal {}
class Fish: Animal { }
class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}

let pets = [Dog(), Fish(), Dog(), Fish()] //[Animal]
for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}
