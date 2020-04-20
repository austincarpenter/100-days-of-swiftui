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
    @State private var round = 1
    
    @State private var showEndOfRoundGameAlert = false
    
    @State private var lastResult: Outcome = .draw
    
    var userOutcome: Outcome {
        //Same
        if userChoice == computerChoice {
            return .draw
        }
        else if userChoice == 0 && computerChoice == 2 {
            return .win
        }
        //Other wise if user's move comes after computer's in array, win, if not, loss
        else {
            return userChoice > computerChoice ? .win : .loss
        }
    }
    
    var gameOutcome: Outcome {
        //User scores less than half of points, loss
        if score < 5 {
            return .loss
        }
        //If more, win
        else if score > 5 {
            return .win
        }
        //Otherwise draw
        else {
            return .draw
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
        }.alert(isPresented: $showEndOfRoundGameAlert) {
            //A bit 'hacky' as the round will go from 10 to 1 before the alert is presented.
            Alert(title: Text("End of \(round == 1 ? "Game" : "Round")"),
                  message: Text(self.lastResult.rawValue),
                  dismissButton: .default(Text("\(round == 1 ? "New Game" : "Next Round")")))
        }
    }
    
    func userMoved(_ move: Move) {
        //Get (which move in terms of ordered set) user chose
        self.userChoice = Move.allCases.firstIndex(of: move)!
        
        //Save result
        self.lastResult = self.userOutcome
        
        //If a win, augment score
        if self.lastResult == .win { self.score += 1 }
        
        //If end of game, store game outcome, not round outcome
        if round == 10 { lastResult = gameOutcome }
        
        //Show alert
        self.showEndOfRoundGameAlert = true
        
        //Begin new round or game
        self.newRoundOrGame()
    }
    
    func newRoundOrGame() {
        //If needed, new game
        if round == 10 {
            round = 0
            score = 0
        }
        
        //New round
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
