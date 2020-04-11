# 100 Days of SwiftUI
My daily log of progress in Paul Hudson's ([@twostraws](https://twitter.com/twostraws)) [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui).

## Days 1-12: Introduction to Swift
### Day 1 – Variables, simple data types, and string interpolation
Today was the first day of the challenge. I was surprised to have learnt that **number literals** can include an **underscores** as thousands separators to improve readability.
```swift
let population = 25_434_405
```
Also, I didn't know that one can **escape newlines** by adding a **backslash character** (`\`) at the end of each line in a multi-line string.
```swift
var string = """
This string \
goes over multiple \
lines. This one won't \
actually include \
the line breaks though.
"""
```
Equivalent to: `"This string goes over multiple lines. This one won't actually include the line breaks though."`
