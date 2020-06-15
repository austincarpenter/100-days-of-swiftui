//
//  User.swift
//  Friends
//
//  Created by Austin Carpenter on 13/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import Foundation

struct UserJSON: Codable, Identifiable {
    var id: UUID
    let name: String
    let age: Int
    let isActive: Bool
    let company: String
    let email: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [Friend]
}

struct Friend: Codable, Identifiable {
    let id: UUID
    let name: String
}

extension UserJSON {
    static var examples: [UserJSON] {
        if let fileURL = Bundle.main.url(forResource: "ExampleUsers", withExtension: ".json"),
            let data = try? Data(contentsOf: fileURL),
            let users = try? JSONDecoder().decode([UserJSON].self, from: data) {
            return users
        }
        
        return []
    }
    
    static let example = UserJSON.examples.first!
}

extension UserJSON {
    
    var registeredDateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        guard let date = formatter.date(from: registered) else {
            return "Unknown Date"
        }
        
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}
