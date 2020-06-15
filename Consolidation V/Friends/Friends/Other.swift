//
//  Other.swift
//  Friends
//
//  Created by Austin Carpenter on 15/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

prefix func !(value: Binding<Bool>) -> Binding<Bool> {
    return Binding<Bool>(get: { return !value.wrappedValue},
                         set: { b in value.wrappedValue = b})
}
