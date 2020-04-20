import UIKit

//"Creating your own structs"
struct Sport {
    var name: String
}

var tennis = Sport(name: "Tennis")
print(tennis.name) //"Tennis"

tennis.name = "Lawn tennis"

//"Computed properties"
struct newSport {
    var name: String
    var isOlympicSport: Bool
    
    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is not an Olympic sport"
        }
    }
}

let chessBoxing = newSport(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus) //"Chessboxing is not an Olympic sport"

//"Property observers"
struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is \(amount)% complete")
        }
    }
}

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30 //"Loading data is 30% complete"
progress.amount = 80 //"Loading data is 80% complete"
progress.amount = 100 //"Loading data is 100% complete"
 
//"Methods"
struct City {
    var population: Int
    func collectTaxes() -> Int {
        return population * 1000
    }
}

let london = City(population: 9_000_000)
london.collectTaxes() //9,000,000,000

//"Mutating methods"
struct Person {
    var name: String
    
    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

var person = Person(name: "Ed")
person.makeAnonymous()

print(person.name) //"Anonymous"

//"Properties and methods of strings"
let string = "Hello, how are you?"
print(string.count) //19
print(string.hasPrefix("Hello")) //true
print(string.uppercased()) //"HELLO, HOW ARE YOU?"
print(string.capitalized) //"Hello, How Are You?"
print(string.sorted()) //[" ", " ", " ", ",", "?", "H", {...}, "w", "y"]

//"Properties and methods of arrays"
var toys = ["Woody"]
print(toys.count) //1
toys.append("Buzz")
toys.firstIndex(of: "Buzz") //1
print(toys.sorted()) //["Buzz", "Woody"]
toys.remove(at: 0)\
