//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Austin Carpenter on 13/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Singer)
public class Singer: NSManagedObject {

}

extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

    public var wrappedFirstName: String { firstName ?? "Unknown First Name" }
    public var wrappedLastName: String { lastName ?? "Unknown Last Name" }
}
