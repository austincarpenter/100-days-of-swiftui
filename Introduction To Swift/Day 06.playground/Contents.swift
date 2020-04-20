import UIKit

//"Creating basic closures"
let driving = {
    print("I'm driving in my car")
}

driving()

//"Accepting parameters in a closure"
let biking = { (place: String) in
    print("I'm going to \(place) in my car")
}

biking("London")

//"Returning values from a closure"
let running = { (place: String) -> String in
    return "I'm running to \(place)"
}

let message = running("Bristol")
print(message)

//"Closures as parameters"
let flying = {
    print("I'm flying in my plane.")
}

func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I've arrived!")
}

travel(action: flying)

//Trailing closure syntax
travel() {
    print("I'm riding my scooter.")
}

travel { //Parentheses aren't needed as there are no other parameters
    print("I'm skipping.")
}
