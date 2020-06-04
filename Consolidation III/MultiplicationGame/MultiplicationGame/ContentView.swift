//
//  ContentView.swift
//  MultiplicationGame
//
//  Created by Austin Carpenter on 2/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var gameInProgress = false
    @State private var questions = [Question]()
    
    var body: some View {
        NavigationView {
            ZStack {
                if gameInProgress {
                    GameView(gameInProgress: $gameInProgress, questions: $questions)
                        .background(Color.white)
                        // .transition(.opacity)
                        // .animation(.easeInOut)

                } else {
                    MenuView(gameInProgress: self.$gameInProgress, questions: self.$questions)
                        .background(Color.white)
                        // .transition(.opacity)
                        // .animation(.easeInOut)
                }
            }
            .padding()
            .navigationBarTitle("Times Tables", displayMode: .inline)
        }
    }
}

// struct ContentView_Previews: PreviewProvider {
//     static var previews: some View {
//         ContentView()
//     }
// }
