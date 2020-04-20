//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Austin Carpenter on 20/4/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    enum Move: String, CaseIterable {
        case rock = "🗿"
        case paper = "📃"
        case scissors = "✂️"
    }
    
    enum Outcome: String, CaseIterable {
        case draw = "It was a draw! 🤝"
        case win = "You won! 👏"
        case loss = "You lost! 👎"
    }

    @State private var possibleMoves: [Move] = [.rock, .paper, .scissors].shuffled()
    
    @State private var computerChoice = Int.random(in: 0...2)
    @State private var userChoice = 0
    
    @State private var score = 0
    @State private var round = 0
    
    @State private var showEndOfRoundAlert = false
    @State private var showEndOfGameAlert = false
    
    @State private var lastResult: Outcome = .draw
    
    func userOutcome() -> Outcome {
        if userChoice == computerChoice {
            return .draw
        } else if userChoice == 0 && computerChoice == 2 {
            return .win
        } else {
            return userChoice > computerChoice ? .win : .loss
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Rock, Paper, Scissors!")
                .font(Font.title.weight(.bold))
            Text("Here's my move: \(Move.allCases[computerChoice].rawValue)")
            Text("What's yours?")
            VStack {
                ForEach(0..<possibleMoves.count) { number in
                    Button(action: {
                        self.userMoved(self.possibleMoves[number])
                    }) {
                        Text(self.possibleMoves[number].rawValue)
                    }
                    .font(Font.system(size: 50))
                    .padding(.all, 25)
                    .background(
                        RadialGradient(
                            gradient: Gradient(colors: [.white, .init(white: 0.95)]),
                            center: .center, startRadius: 0, endRadius: 50)
                    )
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.init(white: 0.75), lineWidth: 1))
                    .shadow(color: Color.black.opacity(0.25), radius: 5, x: 0, y: 2)
                    .padding()
                }
            }
            Text("Score: \(score)  |  Round: \(round)")
        }.alert(isPresented: $showEndOfRoundAlert) {
            Alert(title: Text("End of Round"),
                  message: Text(self.lastResult.rawValue),
                  dismissButton: .default(Text("Next Round")))
        }
    }
    
    func userMoved(_ move: Move) {
        self.userChoice = Move.allCases.firstIndex(of: move)!
        self.lastResult = self.userOutcome()
        if self.lastResult == .win { self.score += 1 }
        self.showEndOfRoundAlert = true
        self.newRound()
    }
    
    func newRound() {
        round += 1
        possibleMoves.shuffle()
        computerChoice = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
