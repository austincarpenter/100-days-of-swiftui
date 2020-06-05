//
//  Extensions.swift
//  MultiplicationGame
//
//  Created by Austin Carpenter on 4/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import Foundation
import SwiftUI

extension EdgeInsets {
    init(all inset: CGFloat) {
        self.init(top: -inset, leading: -inset, bottom: -inset, trailing: -inset)
    }
}

extension Double {
    var percentage: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 3
        return formatter.string(from: NSNumber(value: self))!
    }
}

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension AnyTransition {

    static var slideInOutRight: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
        let removal = AnyTransition.move(edge: .trailing)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

extension Array {
    init(repeatingDifferentInstance: (() -> Element), count: Int) {
        self = []
        for _ in 0..<count {
            self.append(repeatingDifferentInstance())
        }
    }
}

