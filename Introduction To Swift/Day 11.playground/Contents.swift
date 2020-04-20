import UIKit

protocol Idenfitiable {
    var id: String { get set }
}

struct User: Idenfitiable {
    var id: String
}

func displayID(thing: Idenfitiable) {
    print("My ID is \(thing.id)")
}

var user = User(id: "007")
displayID(thing: user) //"My ID is 007"

//"Protocol Inheritence"
protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}

protocol Employee: Payable, NeedsTraining, HasVacation { }

//"Extensions"
extension Int {
    func squared() -> Int {
        return self * self
    }
    
    var isEven: Bool {
        return self % 2 == 0
    }
}

let number = 8
number.squared() //64
number.isEven //true

//"Protocol Extensions"
let topGearPresenters = Set(["Jeremy Clarkson", "Richard Hammond", "James May"])
let band = ["Fred", "Fred", "George"]

extension Collection {
    func summarise() {
        print("There are \(count) of us:")
        
        for name in self {
            print(name)
        }
    }
}

topGearPresenters.summarise()
band.summarise()

//"Protocol-oriented programming"
protocol IdentifiableThing {
    var id: String { get set }
    func identify()
}

extension IdentifiableThing {
    func identify() {
        print("My ID is \(id).")
    }
}

struct Person: IdentifiableThing {
    var id: String
}

let bond = Person(id: "007")
bond.identify() //My ID is 007.
