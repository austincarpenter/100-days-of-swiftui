//
//  Order.swift
//  CupcakeCorner
//
//  Created by Austin Carpenter on 9/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import Foundation

struct Order: Codable {
    static let types = ["Vanilla", "Stawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    //Fix SwiftUI bug.
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        !(name.isEmptyOrContainsWhitespace || streetAddress.isEmptyOrContainsWhitespace || city.isEmptyOrContainsWhitespace || zip.isEmptyOrContainsWhitespace)
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
