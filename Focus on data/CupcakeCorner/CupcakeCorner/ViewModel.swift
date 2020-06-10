//
//  ViewModel.swift
//  CupcakeCorner
//
//  Created by Austin Carpenter on 10/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var order: Order
    
    init(order: Order) {
        self.order = order
    }
}
