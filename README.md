# 100 Days of SwiftUI
My log of progress in Paul Hudson's ([@twostraws](https://twitter.com/twostraws)) [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui).

## Days 1-12: Introduction to Swift
### Day 1 – Variables, simple data types, and string interpolation
Today was the first day of the challenge. I was surprised to have learnt that **number literals** can include an **underscores** as thousands separators to improve readability.
```swift
let population = 25_434_405 //25434405
```
Also, I didn't know that one can **escape newlines** by adding a **backslash character** (`\`) at the end of each line in a multi-line string.
```swift
var string = """
This string \
goes over multiple \
lines without line breaks.
""" //"This string goes over multiple lines without line breaks."
```

### Day 2 – Arrays, dictionaries, sets, and enums
I actually started this on Day 1 as I was really loving the little snippets of code giving me a refresher on some of Swift's basics. For example, I wasn't aware that one can provide a **fallback option** when accessing a `nil` value in a dictionary.
```swift
let favouriteColours = [
    "Austin": "Blue",
    "Fred"  : "Green",
    "Emma"  : "Yellow"
]
favouriteColours["Jack"] //nil
favouriteColours["Jack", default: "Unknown"] //"Unknown"
```
I also hadn't really used **associated values** with an `Enum` before.
```swift
enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}
let talking = Activity.talking(topic: "football")
```
We can then test for the values using a `switch` statement:
```swift
switch talking { //Accessing associated values
    case .talking(topic: "football"): print("⚽️") //"⚽️"
    case .talking(topic: "baseball"): print("⚾️")
    case .talking(topic: "tennis"): print("🎾")
    default: print("❓")
}
```

### Day 3 – Operators and conditions
Today I learnt about **operator overloading**, which is when an operator's function changes based on the operands it operates on - hopefully that made sense!

For example the `+` operator can do many things:
```swift
let bigNumber = 42 + 42 //arithmetic
let longGreeting = "Hello!" + " " + "How are you today?" //joins strings
let letters = ["a", "b", "c"] + ["d", "e", "f"] //joins arrays
```
Secondly, whilst I was aware one could use the `+` operator to join strings, I didn't realise one could use a comparison operator such as `>` to see which string would come first in a dictionary, for example.
```swift
let aComesBeforeB = "a" < "b" //true
```
Lastly the `fallthrough` key word I learnt allows the next case in a `switch` statement to be executed, **without checking the condition**. This can be used like this:
```swift
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"

switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description) //"The number 5 is a prime number, and also an integer."
```
### Day 4 – Loops
Today covered all types of loops as well as lesser-known features of swift such as the ability to **name** loops so that nested loops may be able to break out of outer loops.

It also didn't occur to me that a **range** (either partial or closed) **can be stored in a variable** to use later on such as:
```swift
let count = 1...10

for number in count {
    print("Number is \(number)")
}
```

### Day 5 – Functions
Today's recap of functions was particularly useful as I was able to solidify some gaps in my knowledge, such as how **throwing functions** work and are defined; and that one **must** define an error of type `Error` to be thrown such as:
```swift
enum PasswordError: Error {
    case obvious, tooShort, noNumbers
}
```
**Variadic functions** (functions with parameters that may take multiple values) was fairly new to me. As Paul pointed out, the `print()` function is itself a variadic function. Multiple objects may be passed in to be printed. Swift converts these to an array with the same parameter name that may be looped through later on. One must put an ellipsis (`...`) after a parameter to make it variadic.
```swift
func square(_ numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}
square(1, 2, 3, 4, 5)
```
**Inout parameters** were new to me as well. These are parameters whose original values outside the function may be changed by that function.
```swift
func doubleInPlace(number: inout Int) {
    number *= 2
}
```
The ampersand character (`&`) must be used before the parameter
```swift
var myNum = 10
doubleInPlace(number: &myNum) //20
```
Lastly, the **print function** actually has **more than one parameter**: `separator`, which by default is  `" "` (space) and is used to separate the values to be printed; and `terminator`, which by default is `"."` and is used at the end of the output.
