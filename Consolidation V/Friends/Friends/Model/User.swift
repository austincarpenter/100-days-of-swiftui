//
//  User.swift
//  Friends
//
//  Created by Austin Carpenter on 15/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(User)
public class User: NSManagedObject { }


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var isActive: Bool
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: Set<Tag>?
    @NSManaged public var friends: Set<User>?

}

extension User {
    var wrappedName: String { name ?? "Unknown Name" }
    var wrappedCompany: String { company ?? "Unknown Company" }
    var wrappedEmail: String { email ?? "Unknown Email"}
    var wrappedDescription: String { about ?? "Unknown Description" }
    var wrappedRegisteredDate: Date { registered ?? Date() }
    var registeredDateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: wrappedRegisteredDate)
    }
    var tagsArray: [Tag] {
        get { Array(tags ?? []) }
        set { tags = Set(newValue) }
    }
    var friendsArray: [User] {
        get { Array(friends ?? []) }
        set { friends = Set(newValue) }
    }
}

extension User {

    static var examples: [User] {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        let viewModel = ViewModel(moc: context)
        viewModel.createCoreDataData(users: UserJSON.examples)
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        return (try? context.fetch(fetchRequest)) ?? []
    }
    
    static var example: User { examples.first! }
}
// MARK: Generated accessors for tags
extension User {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}

// MARK: Generated accessors for friends
extension User {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: User)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: User)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}
