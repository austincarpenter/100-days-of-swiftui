import UIKit

//"Arithmetic Operators"
let firstScore = 12
let secondScore = 4

let total = firstScore + secondScore //16
let difference = firstScore - secondScore //8

let product = firstScore * secondScore //48
let divided = firstScore / secondScore //3

let remainder = 13 % secondScore //1

//"Operator overloading"
let meaningOfLife = 42
let doubleMeaning = 42 + 42 //84

let hello = "hello"
let space = " "
let world = "world"
let greeting = hello + space + world //"hello world"

let primaryColours = ["Red", "Yellow", "Blue"]
let secondaryColours = ["Purple", "Green", "Orange"]
let colours = primaryColours + secondaryColours

//"Compound assignment operators"
var score = 95
score -= 5 //90

var quote = "O Romeo, Romeo, wherefore art thou"
quote += "Romeo?" //O Romeo, Romeo, wherefore art thou Romeo?

//"Comparison operators"
let score1 = 6
let score2 = 4

score1 == score2 //false
score1 != score2 //true
score1 < score2  //false
score1 >= score2 //true

"Taylor" <= "Swift" //false

//"Conditions"
let firstCard = 11
let secondCard = 10

if firstCard + secondCard == 2 {
    print("Aces – lucky!")
} else if firstCard + secondCard == 21 { //true
    print("Blackjack!")
} else {
    print("Regular cards")
}

//"Combining conditions"
let age1 = 12
let age2 = 21

if age1 > 18 && age2 > 18 { // false
    print("Both are over 18")
}

if age1 > 18 || age2 > 18 { // true
    print("At least one is over 18")
}

//"The ternary operator"
let card1 = 11
let card2  = 10
print(firstCard == secondCard ? "Cards are the same" : "Cards are different") //"Cards are different"

//"Switch statements"
let weather = "sunny"

switch weather {
    case "rain":
        print("Bring an umbrella")
    case "snow":
        print("Wrap up warm")
    case "sunny": //true
        print("Wear suncreen")
        fallthrough
    default:
        print("Enjoy your day!")
}

//"Range operators"
let result = 85

switch result {
    case 0..<50:
        print("You failed badly.")
    case 50..<85:
        print("You did OK.")
    case 85...100: //true
        print("You did great!")
    default:
        print("Your score isn't even on the scale!")
}
