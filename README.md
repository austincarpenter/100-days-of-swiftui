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

### Day 6 – Closures (Part 1)
Ah closures, how confusing they can be! I found however, that once the closures and their uses became *more complicated*, funnily enough, I understood them *more*. In the simpler examples, I found myself thinking: "Why not just use a function here instead?" which became annoying quickly.

In my little experience with closures so far, I find functions which incorporate `for` loops inside which is a closure to be easier to understand. For example:

```swift
func repeatAction(count: Int, action: () -> Void) {
	for _ in 0..<count {
		action()
	}
}
repeatAction(count: 5) {
	print("Hello, world!")
}
```
This `for` loop however could still however be extracted from the function and used in-line, therefore eliminating the need for the closure entirely. This is a very simple example however, so with more complex behaviour inside the function, the code above wouldn't be so redundant.

### Day 7 – Closures (Part 2)
Closures are beginning to make more sense. While they are still settling inside my brain I won't point out too much of what I have learned, because it was basically everything Paul covered. Below is an example from today which I extended which shows the power of closures. It allows the user to generate primes and process each one using a closure:

```swift
func processPrimes(upToButNotIncluding n: Int, using closure: (Int) -> Void) {
    let primes = {...}
    for prime in primes {
        closure(prime)
    }
}
processPrimes(upToButNotIncluding: 10) { prime in
    print("\(prime) is a prime number.")
    print("\(prime) squared is \(prime * prime).")
}
```
The closure in the `processPrimes(upToButNotIncluding:)` function can also be defined elsewhere and then reused, as well as others which may be used later on.
```swift
let printSquared = { (number: Int) in
    print("\(number) is a prime number.")
    print("\(number) squared is \(number * number)")
}

let printCubed = { (number: Int) in
    print("\(number) is a prime number.")
    print("\(number) cubed is \(number * number * number)")
}
```
These could then be added to an array or defined in an `enum` so that the user may select the closure to use from a variety of options, however that's getting a bit more complicated.
```swift
processPrimes(upToButNotIncluding: 10, using: printSquared)
processPrimes(upToButNotIncluding: 4, using: printCubed)
```

### Day 8 – Structs (Part 1)
Today was pretty straightforward, however, like always I learned a couple of things. Firstly, the phrase **'property observer'** I had heard before but didn't realise it explicitly referred to the `willSet` and `didSet` observers that are called before and after a property is changed, respectively.

Secondly, I didn't realise that if a function inside that struct wishes to modify one of its properties, regardless of how the struct is declared it must be prefixed with the `mutating` keyword. Below the `name` property of `person` can only be changed from inside the struct definition by adding this keyword.

```swift
struct Person {
    var name: String

    mutating func changeName(to newName: String) {
        name = newName
    }
}

var person = Person(name: "Austin")
person.name = "Fred"
person.changeName(to: "Tom")
```

### Day 9 – Structs (Part 2)
Today I was interested to learn that structs don't require one to define an initialiser for themselves. Instead, a **default memberwise initialiser** is created, accepting values for all properties in the struct.

```swift
struct User {
    var username: String
}

var user = User(username: "austin")
```

However, if one defines a custom default initialiser, the one created automatically is no longer available. A neat trick to get around this is to wrap the custom initialiser in an extension of the struct.
```swift
struct Person {
    var firstName: String
    var lastName: String
}

extension Person {
    init(name: String) {
        let split = name.components(separatedBy: " ")
        firstName = split.first ?? ""
        lastName = split.last ?? ""
    }
}
```
Now both can be used.
```swift
let fred1 = Person(firstName: "Fred", lastName: "Smith")
let fred2 = Person(name: "Fred Smith")
```
Also, the usefulness of `lazy` properties. These are simply properties that are only instantiated when their value are read or written and are useful for perhaps large classes (which themselves possibly instantiate other classes) which aren't required to be held in memory at runtime.

### Day 10 – Classes
Today was a refresher on classes. To ensure I was rock-solid about the differences between them and structs, I thought I'd make a list of what I remember.

1. Classes hold **references** to their properties' values in memory, whilst the properties of a struct hold the **values** themselves.
2. Classes can have inheritance
3. Classes must have a defined initialiser
4. Classes can have a defined `deinit()` method
5. Classes don't enforce constants as strongly as structs (in that classes instantiated as constants may still have variable properties)

### Day 11 – Protocols and Extensions
Today I learnt that protocols can have **extensions** in which **functions can be defined** such as:
```swift
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
```
I also learnt that in some ways protocols serve as way of 'subclassing multiple classes' at once, as classes may only truly inherit from one class at a time, but may still conform to multiple protocols. This makes the following acceptable, for example:

```swift
protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}
```
Now one may create a simple `Employee` protocol that inherits from the three we just created:
```swift
protocol Employee: Payable, NeedsTraining, HasVacation { }
```

### Day 12 – Optionals, Unwrapping and Typecasting
The final day in the refresher to basic Swift taught about a few things. Firstly: **optional chaining**. This allows accessing `c` in `a.b.c` if `b` is optional, via `a.b?.c`. If `b` is `nil`, `c` will be `nil`.

Secondly the use of `try?` as an alternative to `do {} catch {}`. This basically skips the error handling part (`catch`) and will return an optional instead. Another alternative to `do {} catch {}` is:
```swift
if let = try? ... {
  ...
} else {
  ...
}
```
This doesn't however allow for different errors to be handled individually, as none are caught in the first place, so it should be used sparingly.

Lastly, the notion of **failable initialisers**, which are simply initialisers whose `init` keyword may be suffixed with `?` to allow them to return nil if a certain condition is not met (for example) in the initialiser body.

## Days 13-15 – Consolidation
I chose to skim read this section as I had just completed the 15 day review of the language and felt with my documentation and experience with the language I could more or less dive into SwiftUI.

## Days 16-24 – Starting SwiftUI

### Days 16-18 – Project 1: WeSplit

### Day 19 – Challenge Day: LengthConverter

### Days 20-22 – Project 2: GuessTheFlag

### Days 34-24 – Project 3: ViewsAndModifiers
