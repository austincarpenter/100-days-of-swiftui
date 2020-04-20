import UIKit

//"Creating Classes"
class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

let poppy = Dog(name: "Poppy", breed: "Poodle")

//"Class inheritance"
class Poodle: Dog {
    override init(name: String, breed: String) {
        super.init(name: name, breed: "Poodle")
    }
}

//"Overriding Methods"
class Bird {
    func makeNoise() {
        print("Chirp!")
    }
}

class Cockatoo: Bird {
    override func makeNoise() {
        print("Sqwawk")
    }
}

let felix = Bird()
felix.makeNoise() //"Sqwawk"

//"Final classes"
final class Cat { //Cannot be subclassed
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

//"Copying objects"
class Singer {
    var name = "Talor Swift"
}

var singer = Singer()
print(singer.name)

var singerCopy = singer
singerCopy.name = "Justin Bieber"

print(singer.name) //"Justin Bieber"

//"Deinitialisers"
class Person {
    var name = "John Done"
    
    init() {
        print("\(name) is alive!")
    }
    
    func printGreeting() {
        print("Hello, I'm \(name)")
    }
    
    deinit {
        print("\(name) is no more!")
    }
}

for _ in 1...3 {
    let person = Person()
    person.printGreeting()
}

//"Mutability"
class Actor {
    var name = "Chris Hemsworth"
}

let chris = Actor()
chris.name = "Goerge Clooney" //Valid to change value
print(chris.name)
