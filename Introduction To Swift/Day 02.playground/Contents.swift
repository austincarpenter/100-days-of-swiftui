import UIKit

//"Arrays"
let john = "John Lennon"
let paul = "Paul McCartney"
let goerge = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [john, paul, goerge, ringo]
beatles[1] //"Paul McCartney"

//"Sets"
let colours = Set(["red", "green", "blue"])
let colours2 = Set(["red", "green", "blue", "red", "blue"]) //Set(["green", "red", "blue"])

//"Tuples"
var name = (first: "Taylor", last: "Swift")
name.0 //"Taylor"
name.last //"Swift"

//"Arrays vs sets vs tuples"
let address = (street: "One Infinite Loop", city: "Cupertino", state: "CA") //Specfic, fixed values
let wordBank = Set(["cat", "car", "candy"]) //Unique, unordered values
let weeklyMaxTemperatures = [20.5, 23, 24, 28, 25.5, 26, 23] //Duplicated, ordered values

//"Dictionaries"
let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]
heights["Taylor Swift"] //1.78

let favouriteColours = [
    "Austin": "Blue",
    "Fred"  : "Green",
    "Emma"  : "Yellow"
]
favouriteColours["Jack"] //nil
favouriteColours["Jack", default: "Unknown"] //"Unknown"

//"Creating empty collections"
var teams = [String: String]() //Or var teams = Dictionary<String, String>()
teams["Austin"] = "Red"

var results = [Int]() //Or var results = Array<Int>()
var words = Set<String>()
var numbers = Set<Int>()

//"Enumerations"
let result = "failure"
let result2 = "failed"
let result3 = "failed"

enum Result {
    case sucess
    case failure
}

let result4 = Result.failure

//"Enum associated values"
enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

let talking = Activity.talking(topic: "football")
switch talking { //Accessing associated values
    case .talking(topic: "football"): print("⚽️")
    case .talking(topic: "baseball"): print("⚾️")
    case .talking(topic: "tennis"): print("🎾")
    default: print("❓")
}

//"Enum raw values"
enum Planet: Int {
    case mercury = 1 //Default 0
    case venus, earth, mars
}

let earth = Planet(rawValue: 3)
