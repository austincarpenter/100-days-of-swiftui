import UIKit

//"For loops"
let count = 1...10

for number in count {
    print("Number is \(number)")
}

let albums = ["Red", "1989", "Reputation"]

for album in albums {
    print("\(album) is on Apple Music")
}

print("Players gonna")

for _ in 1...5 {
    print("play")
}

//"While loops"
var number = 1

while number <= 20 { //20 times
    print(number)
    number += 1
}

print("Ready or not, here I come!")

//"Repeat loops"
var newNumber = 1

repeat { //20 times
    print(newNumber)
    newNumber += 1
} while newNumber <= 20

print("Ready or not, here I come!")

while false {
    print("This is false") //Never executed
}

repeat {
    print("This is false")
} while false

//"Exiting loops"
var countDown = 10

while countDown >= 0 { //7 times
    print(countDown)
    
    if countDown == 4 {
        print("I'm bored. Let's go now!")
        break
    }
    
    countDown -= 1
}

print("Blast off!")

//"Exiting multiple loops"
outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print("\(i) * \(j) is \(product)")
        
        if product == 50 {
            print("It's a bullseye!")
            break outerLoop
        }
    }
}

//"Skipping items"
for i in 1...10 {
    if i % 2 == 1 { //Odd number
        continue
    }
    print(i) //5 times
}

//"Infinite loops"
var counter = 0

while true { //273 times
    print(" ")
    counter += 1
    
    if counter == 273 {
        break
    }
}
