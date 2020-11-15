//
//  ContentView.swift
//  MultiplicationGame
//
//  Created by Austin Carpenter on 2/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    //General
    @State private var gameInProgress = false
    @State private var questions = [Question]()
    
    //Menu
    @State private var multiplierSelected = 5
    @State private var upperMultiplier = 12
    @State private var gameMode: GameMode = .five

    //Game
    @State private var currentQuestion = 0
    @State private var currentAnswer = "0"
    @State private var correctAnswers = 0
    @State private var answeredQuestions = 0
    @State private var showingAlert = false
    @State private var confettiPresented = false
    
    var percentageCorrect: String {
        guard answeredQuestions != 0 else { return "–%" }
        return (Double(correctAnswers) / Double(answeredQuestions)).percentage
    }
    // let confettiIntensity: Float = 0.5
    
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

    var menuView: some View {
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
                    RoundedButton(text: mode == .all ? "All" + "\n" + "(\(2 * (self.upperMultiplier + 1)))" : String(mode.rawValue), filled: mode == self.gameMode) {
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
        .padding(.horizontal)
        .navigationBarTitle("Times Tables", displayMode: .inline)
    }

    var gameView: some View {
        ZStack {
            VStack(spacing: 15) {
                Text("\(questions[safe: currentQuestion]?.firstOperand ?? 0) x \(questions[safe: currentQuestion]?.secondOperand ?? 0)")
                    .font(Font.largeTitle.weight(.heavy))
                Divider()
                VStack(spacing: 20) {
                    TextField("0", text: $currentAnswer).multilineTextAlignment(.center)
                        .font(Font.largeTitle.weight(.heavy))
                        .padding(.vertical)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(5)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(UIColor.systemGray5)))

                    Keypad(font: .title, backspaceAction: {
                        self.currentAnswer = (self.currentAnswer == "0" || self.currentAnswer.count == 1 ? "0" : String(self.currentAnswer.dropLast()))
                    }, keypadAction: { code in
                        self.currentAnswer = (self.currentAnswer == "0" ? "\(code)" : self.currentAnswer + "\(code)")
                    })
                }
                .padding(.horizontal, 40)
//                .padding(.horizontal)
                Divider()
                VStack {
                    HStack(spacing: 20) {
                        Text("\(correctAnswers)/\(answeredQuestions)")
                        Text(percentageCorrect)
                    }.font(Font.title.weight(.heavy))
                    Text("Correct").font(.headline)
                }
                HStack(spacing: 15) {
                    RoundedButton(text: "Cancel", filled: true, accentColor: .red, maxHeight: 50) {
                        self.endGame()
                    }
                    RoundedButton(text: currentQuestion < questions.count - 1 ? "Next" : "Finish", filled: true, maxHeight: 50) {
                        self.nextQuestion()
                    }
                }.padding(.horizontal)
            }
            if confettiPresented {
                ConfettiView()
                    .allowsHitTesting(false)
                    .opacity(confettiPresented ? 1 : 0)
            }
        }
        .navigationBarTitle("Question \(currentQuestion + 1)/\(questions.count)", displayMode: .inline)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("End of Game"),
                message: Text(endOfGameText),
                primaryButton:
                    .default(Text("Menu")) {
                        self.endGame()
                    },
                secondaryButton:
                    .default(Text("New Game")) {
                        self.startGame()
                    }
            )
        }
    }
        
    var body: some View {
        NavigationView {
            ZStack {
                if gameInProgress {
                    gameView
                        .background(Color.white)
                } else {
                    menuView
                        .background(Color.white)
                }
            }
            .padding(.top)
        }
    }
    
    func startGame() {
        resetGame()
        generateQuestions()
        gameInProgress = true
    }
    
    func resetGame() {
        currentQuestion = 0
        currentAnswer = "0"
        correctAnswers = 0
        answeredQuestions = 0
        questions = []
    }
    
    func endGame() {
        gameInProgress = false
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

    func nextQuestion() {
        answeredQuestions += 1
        if Int(currentAnswer)! == questions[currentQuestion].answer {
            correctAnswers += 1
        }
        if currentQuestion < questions.count - 1 {
            currentQuestion += 1
            currentAnswer = "0"
        } else {
            if Double(correctAnswers) / Double(answeredQuestions) >= 0.85 {
                confettiPresented = true
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
                    self.confettiPresented = false
                }
            }
            showingAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
