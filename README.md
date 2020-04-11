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
""" //This string goes over multiple lines without line breaks.
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
    case .talking(topic: "football"): print("⚽️")
    case .talking(topic: "baseball"): print("⚾️")
    case .talking(topic: "tennis"): print("🎾")
    default: print("❓")
}
```
