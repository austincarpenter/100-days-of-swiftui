//
//  Order.swift
//  CupcakeCorner
//
//  Created by Austin Carpenter on 9/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import Foundation

//@Published conformance to Codable
//from https://blog.hobbyistsoftware.com/2020/01/adding-codeable-to-published/
extension Published:Decodable where Value:Decodable {
    public init(from decoder: Decoder) throws {
        let decoded = try Value(from:decoder)
        self = Published(initialValue:decoded)
    }
}

extension Published:Encodable where Value:Decodable {

    public func encode(to encoder: Encoder) throws {

        let mirror = Mirror(reflecting: self)
        if let valueChild = mirror.children.first(where: { $0.label == "value"
        }) {
            if let value = valueChild.value as? Encodable {
                do {
                    try value.encode(to: encoder)
                    return
                } catch let error {
                    assertionFailure("Failed encoding: \(self) - \(error)")
                }
            }
            else {
                assertionFailure("Decodable Value not decodable. Odd \(self)")
            }
        }
        else {
            assertionFailure("Mirror Mirror on the wall - why no value y'all : \(self)")
        }
    }
}

class Order: ObservableObject, Codable {
    static let types = ["Vanilla", "Stawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    //Fix SwiftUI bug.
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool {
        !(name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty)
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
}
