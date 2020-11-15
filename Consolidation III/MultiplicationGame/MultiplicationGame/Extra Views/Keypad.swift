//
//  Keypad.swift
//  MultiplicationGame
//
//  Created by Austin Carpenter on 3/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI


struct Keypad: View {

    var font: Font = .title
    var padding: CGFloat = 5.0
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
    }
}

struct Keypad_Previews: PreviewProvider {
    static var previews: some View {
        let padding: CGFloat = 10
        return Keypad(padding: padding)
            .padding(2 * padding)
    }
}
