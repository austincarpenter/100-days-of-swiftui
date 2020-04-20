//
//  ContentView+Challenges.swift
//  ViewsAndModifiers
//
//  Created by Austin Carpenter on 20/4/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct TitleText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.title.weight(.bold))
            .foregroundColor(.blue)
    }
}

struct ContentView_Challenges: View {
    var body: some View {
        VStack {
            Text("GridStack Demonstration")
                .titleStyle()
            GridStack(rows: 4, columns: 4) { row, col in
                HStack {
                    Image(systemName: "\(row * 4 + col).circle")
                    Text("R\(row) C\(col)")
                }
            }
        }
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(TitleText())
    }
}

struct ContentView_Challenges_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_Challenges()
    }
}
