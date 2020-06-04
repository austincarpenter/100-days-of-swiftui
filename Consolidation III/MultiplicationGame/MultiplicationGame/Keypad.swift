//
//  Keypad.swift
//  MultiplicationGame
//
//  Created by Austin Carpenter on 3/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

extension EdgeInsets {
    init(all inset: CGFloat) {
        self.init(top: -inset, leading: -inset, bottom: -inset, trailing: -inset)
    }
}
struct Keypad: View {

    var font: Font = .title
    var padding: CGFloat = 10.0
    var backspaceAction: (() -> Void)?
    var keypadAction: ((Int) -> Void)?
    
    func span(columns: Int, totalColumns: Int, totalWidth: CGFloat, padding: CGFloat) -> CGFloat {
        let calculatedWith = totalWidth - (CGFloat(2) * CGFloat(totalColumns) * padding)
        let ratio = CGFloat(columns)/CGFloat(totalColumns)
        let extraPadding = 2 * (CGFloat(columns) - 1) * padding
        return (calculatedWith * ratio) + extraPadding
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                ForEach(0..<3, id: \.self) { row in
                    HStack {
                        ForEach<Range<Int>, Int, AnyView>(0..<3, id: \.self) { column in
                            let value = (row) * 3 + (column + 1)
                            return AnyView(
                                RoundedButton(text: "\(value)", font: self.font) {
                                (self.keypadAction ?? {_ in })(value)
                            }
                            .font(.title)
                                .padding(self.padding)
                            )
                        }
                    }
                }
                HStack {
                    RoundedButton(text: "0", font: self.font) {
                        (self.keypadAction ?? {_ in })(0)
                    }
                    .frame(width: self.span(columns: 2, totalColumns: 3, totalWidth: geometry.size.width, padding: self.padding))
                    .padding(self.padding)
                    RoundedButton(text: "←", font: self.font, accentColor: .red) {
                        (self.backspaceAction ?? { })()
                    }
                    .padding(self.padding)
                }
            }
        }.padding(EdgeInsets(all: self.padding))

        // GridStack<AnyView>(rows: 3, columns: 3, padding: 10) { (row, column) in
        //     let value = "\((row) * 3 + (column + 1))"
        //     return AnyView(
        //         RoundedButton(filled: false, text: value, accentColor: .blue) {
        //         self.currentAnswer = (self.currentAnswer == "0" ? "\(value)" : self.currentAnswer + "\(value)")
        //     }.font(.title))
        // }
        // HStack(spacing: 20) {
        //     RoundedButton(filled: false, text: "0", accentColor: .blue) {
        //         self.currentAnswer = (self.currentAnswer == "0" ? "0" : self.currentAnswer + "0")
        //     }.font(.title)
        //     .frame(width: 150)
        //     RoundedButton(filled: false, text: "←", accentColor: .red) {
        //         self.currentAnswer = (self.currentAnswer == "0" || self.currentAnswer.count == 1 ? "0" : String(self.currentAnswer.dropLast()))
        //     }.font(.title)
        //     .frame(width: 65)
        // }
    }
}

struct Keypad_Previews: PreviewProvider {
    static var previews: some View {
        let padding: CGFloat = 10
        return Keypad(padding: padding)
            .padding(2 * padding)
    }
}
