//
//  Tag.swift
//  Friends
//
//  Created by Austin Carpenter on 15/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Tag)
public class Tag: NSManagedObject { }

extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var value: String?
    @NSManaged public var users: NSSet?

}

extension Tag {
    var wrappedValue: String { value ?? "Unknown Value" }
    var usersArray: [User] { users?.allObjects as? [User] ?? [] }
}

// MARK: Generated accessors for users
extension Tag {

    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: User)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: User)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSSet)

}
