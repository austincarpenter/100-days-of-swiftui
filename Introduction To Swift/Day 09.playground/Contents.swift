import UIKit

//"Initialisers"
struct User {
    var username: String
}

var user = User(username: "austin")

struct AnonymousUser {
    var username: String
    
    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}

var user2 = AnonymousUser() //"Creating a new user!"
user2.username = "Austin"

//"Referring to the current instance"
struct NewPerson {
    var name: String
    
    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}

var newPerson = NewPerson(name: "Austin") //"Austin was born!"

//"Lazy properties"
struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}

struct PersonInTree {
    var name: String
    lazy var familyTree = FamilyTree()
}

var ed = PersonInTree(name: "Ed")
ed.familyTree //Creating family tree!

//"Static properties and methods"
struct Student {
    static var classSize = 0
    
    var name: String

    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}

let taylor = Student(name: "Taylor")
let fred = Student(name: "Fred")

print(Student.classSize) //2

//"Access control"
struct SecurePerson {
    private var id: String
    
    init(id: String) {
        self.id = id
    }
    
    func identify() -> String {
        return "My social security number is \(id)"
    }
}

let john = SecurePerson(id: "12345")
print(john.identify()) //My social security number is 12345
