//
//  GameView.swift
//  MultiplicationGame
//
//  Created by Austin Carpenter on 2/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

extension Double {
    var percentage: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 3
        return formatter.string(from: NSNumber(value: self))!
    }
}

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

struct GameView: View {
    
    @Binding var gameInProgress: Bool
    @Binding var questions: [Question]
    
    @State private var currentQuestion = 0
    @State private var currentAnswer = "0"
    @State private var correctAnswers = 0
    @State private var answeredQuestions = 0
    @State private var showingAlert = false
    
    var endOfGameText: String {
        let score = Double(correctAnswers) / Double(answeredQuestions)
        var string = "You scored \(correctAnswers)/\(answeredQuestions) (\(score.percentage)). "
        switch score * 100 {
            case 50..<65:
                string += "Might need some more practice..."
            case 65..<75:
                string += "Not bad."
            case 75..<85:
                string += "Good job."
            case 85...100:
                string += "Excellent work!"
            default:
                string += "Hmmm... you need to do this everyday to improve!"
        }
        return string
    }
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Question \(currentQuestion + 1)/\(questions.count)")
                .font(.headline)
            
            Text("\(questions[safe: currentQuestion]?.firstOperand ?? 0) x \(questions[safe: currentQuestion]?.secondOperand ?? 0)")
                .font(Font.largeTitle.weight(.heavy))
            Divider()
            VStack(spacing: 20) {
                TextField("0", text: $currentAnswer).multilineTextAlignment(.center)
                    .font(Font.largeTitle.weight(.heavy))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Keypad(font: .title, backspaceAction: {
                    self.currentAnswer = (self.currentAnswer == "0" || self.currentAnswer.count == 1 ? "0" : String(self.currentAnswer.dropLast()))
                }, keypadAction: { code in
                    self.currentAnswer = (self.currentAnswer == "0" ? "\(code)" : self.currentAnswer + "\(code)")
                })
            }.padding(.horizontal, 40)
            Divider()
            Text("\(correctAnswers)/\(answeredQuestions) Correct")
                .font(.headline)
            HStack(spacing: 20) {
                RoundedButton(text: "Cancel", filled: true, accentColor: .red, maxHeight: 50) {
                    self.endGame()
                }
                RoundedButton(text: currentQuestion < questions.count - 1 ? "Next" : "Finish", filled: true, maxHeight: 50) {
                    self.nextQuestion()
                }
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("End of Game"),
                message: Text(endOfGameText),
                dismissButton:
                    .default(Text("Menu")) {
                        self.endGame()
                    }
            )
        }
    }
    
    func endGame() {
        correctAnswers = 0
        answeredQuestions = 0
        questions = []
        gameInProgress = false
    }
    
    func nextQuestion() {
        answeredQuestions += 1
        if Int(currentAnswer)! == questions[currentQuestion].answer {
            correctAnswers += 1
        }
        if currentQuestion < questions.count - 1 {
            currentQuestion += 1
            currentAnswer = "0"
        } else {
            showingAlert = true
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GameView(gameInProgress: .constant(true), questions: .constant([
                Question(firstOperand: 5, secondOperand: 3),
                Question(firstOperand: 4, secondOperand: 8),
                Question(firstOperand: 7, secondOperand: 5)
            ]))
                .padding()
                .navigationBarTitle("Times Tables", displayMode: .inline)
        }
    }
}
