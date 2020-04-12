import UIKit

//"Writing Functions"
func printHelp() {
    let message = """
Welcome to MyApp!

Run this app inside a directory of images and
MyApp will resize them all into thumbnals
"""
    
    print(message)
}

printHelp()

//"Accepting parameters"
print("Hello, world!")

func square(number: Int) {
    print(number * number)
}

square(number: 8) //64

//"Returning values"
func square2(number: Int) -> Int {
    return number * number
}

let result = square2(number: 8) //64
print(result) //64

//"Parameter labels"
func sayHello(to name: String) {
    print("Hello, \(name)!")
}

sayHello(to: "Austin")

//"Omitting parameter labels"
func greet(_ person: String) {
    print("Hello, \(person)!")
}

greet("Austin") //"Hello, Austin!"

//"Default parameters"
func greet2(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}

greet2("Taylor") //"Hello, Taylor!"
greet2("Taylor", nicely: false) //"Oh no, it's Taylor again..."

//"Variadic functions"
func anotherSquare(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}

anotherSquare(numbers: 1, 2, 3, 4, 5)

//"Writing throwing functions"
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" { //true
        throw PasswordError.obvious
    }
    return true
}

do {
    try checkPassword("password")
    print("That passwor is good!")
} catch {
    print("You can't use that password.") // "You can't use that password."
}

//Inout parameters
func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 10
doubleInPlace(number: &myNum) //20
