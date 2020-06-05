//
//  Question.swift
//  MultiplicationGame
//
//  Created by Austin Carpenter on 2/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import Foundation

struct Question {
    let firstOperand: Int
    let secondOperand: Int
    var answer: Int { firstOperand * secondOperand }
}
