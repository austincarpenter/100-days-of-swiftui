import UIKit

//"Using closures as parameters when they accept parameters"
func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}

travel { (place: String) in
    print("I'm going to \(place) in my car")
}

//"Using closures as parameters when they return values"
func travel2(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

travel2 { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

//"Shorthand parameter names"
travel2 { place -> String in //removed parameter type
    return "I'm going to \(place) in my car"
}

travel2 { place in //removed return type
    return "I'm going to \(place) in my car"
}

travel2 { place in
    "I'm going to \(place) in my car" //removed return keyword
}

travel2 {
    "I'm going to \($0) in my car" //automatic name for parameter
}

//"Closures with multiple parameters"
func travel3(action: (String, Int) -> String) {
    print("I'm getting ready to go.")
    let description = action("London", 60)
    print(description)
    print("I arrived!")
}

travel3 {
    "I'm going to \($0) at \($1) miles per hour."
}

//"Returning closures from functions"
func travel4() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}

let result = travel4()
result("London")

let result2 = travel4()("London") //not recommended

//"Capturing values"
func travel5() -> (String) -> Void {
    var counter = 1

    return {
        print("\(counter). I'm going to \($0)")
        counter += 1
    }
}

let result3 = travel5()
result3("London") //1. I'm going to London
result3("London") //2. I'm going to London
result3("London") //3. I'm going to London

let result4 = travel5() //Counter restarted for new variable
result4("London") //1. I'm going to London
result4("London") //2. I'm going to London
result4("London") //3. I'm going to London


