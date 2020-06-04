//
//  RoundedButton.swift
//  MultiplicationGame
//
//  Created by Austin Carpenter on 2/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct RoundedButtonStyle: ButtonStyle {
    
    var font: Font = .body
    var filled: Bool = false
    var accentColor: Color = .blue
    var maxHeight: CGFloat = 75

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(font.weight(.semibold))
            .multilineTextAlignment(.center)
            .frame(maxHeight: maxHeight)
            .background(filled ? accentColor : Color.init(.init(white: 1.0, alpha: 0.0001))) //Color.clear or UIColor.clear don't generate touch event
            .foregroundColor(filled ? Color.white : accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(accentColor, lineWidth: 2)
            )
            .animation(nil)
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
            .animation(.easeInOut(duration: 0.25))
    }
}
struct RoundedButton: View {
    
    var text: String
    var font: Font = .body
    var filled: Bool = false
    var accentColor: Color = .blue
    var maxHeight: CGFloat = 75
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            HStack {
            Spacer()
            Text(text)
            Spacer()
            }
        }
        .buttonStyle(RoundedButtonStyle(font: font, filled: filled, accentColor: accentColor, maxHeight: maxHeight))
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 10) {
            RoundedButton(text: "Normal")
            RoundedButton(text: "Selected")
            Divider()
            RoundedButton(text: "Destructive", filled: true, accentColor: .red)
            RoundedButton(text: "Disabled", filled: true, accentColor: .gray)
                .disabled(true)
        }.padding()
    }
}

