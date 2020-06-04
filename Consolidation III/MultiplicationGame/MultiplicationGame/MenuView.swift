//
//  MenuView.swift
//  MultiplicationGame
//
//  Created by Austin Carpenter on 2/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    
    enum GameMode: Int, CaseIterable {
        case five = 5, ten = 10, twenty = 20, all = 0
    }
    
    @State private var multiplierSelected = 5
    @State private var upperMultiplier = 12
    @State private var gameMode: GameMode = .five

    @Binding var gameInProgress: Bool
    @Binding var questions: [Question]

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Times table to practise")
                .font(.headline)
            HStack {
                Text("\(multiplierSelected)")
                    .font(.title)
                    .bold()
                Stepper("", value: $multiplierSelected, in: 1...upperMultiplier)
            }
            Divider()
            Text("Highest number to multiply")
                .font(.headline)
            HStack {
                Text("\(upperMultiplier)")
                    .font(.title)
                    .bold()
                Stepper("", value: $upperMultiplier, in: 1...20)
            }
            Divider()

            Text("Number of rounds")
                .font(.headline)
            HStack(spacing: 15) {
                ForEach(GameMode.allCases, id: \.self) { mode in
                    RoundedButton(text: mode == .all ? "All" + "\n" + "(\(2 * self.upperMultiplier + 1))" : String(mode.rawValue), filled: mode == self.gameMode) {
                        self.gameMode = mode
                    }
                    .frame(idealHeight: 75)
                    .fixedSize(horizontal: false, vertical: true)

                }
            }
            Spacer()
            RoundedButton(text: "Play", filled: true, maxHeight: 50) {
                self.startGame()
            }
        }
    }
    
    func startGame() {
        generateQuestions()
        gameInProgress = true
    }
    
    func generateQuestions() {
    
        //If all, generate all 12 and 12 with the operands flipped (i.e 1 x 5, 2 x 5, etc., and 5 x 1, 5 x 2, etc.)
        if gameMode == .all {
            for i in 0...upperMultiplier {
                questions += [Question(firstOperand: i, secondOperand: multiplierSelected),
                              Question(firstOperand: multiplierSelected, secondOperand: i)]
            }
    
        //Otherwise generate up to the number they asked for, randomly making the multiplier the first or second operand.
        } else {
            for _ in 0..<gameMode.rawValue {
                if Int.random(in: 0...1) == 0 {
                    questions.append(Question(
                        firstOperand: Int.random(in: 0...upperMultiplier),
                        secondOperand: multiplierSelected)
                    )
                } else {
                    questions.append(Question(
                        firstOperand: multiplierSelected,
                        secondOperand: Int.random(in: 0...upperMultiplier))
                    )
                }
            }
        }
        questions.shuffle()
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MenuView(gameInProgress: .constant(false), questions: .constant([]))
                .padding()
                .navigationBarTitle("Times Tables", displayMode: .inline)
        }
    }
}
