//
//  ContentView+Challenges.swift
//  GuessTheFlag
//
//  Created by Austin Carpenter on 19/4/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    var name: String
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .cornerRadius(20, antialiased: true)
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView_Challenges: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var correctYRotation = 0.0
    @State private var incorrectOpacity = 1.0
    @State private var offsets: [CGSize] = [.zero, .zero, .zero]
    @State private var rotation = 0.0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.setButtonStates(correctAnswer: number == self.correctAnswer)
                        self.flagTapped(number)
                    }) {
                        FlagImage(name: self.countries[number])
                    }
                    .rotation3DEffect(number == self.correctAnswer ? .degrees(self.correctYRotation) : .zero, axis: (x: 0, y: 1, z: 0))
                    .opacity(number == self.correctAnswer ? 1.0 : self.incorrectOpacity)
                    .rotationEffect(.degrees(self.rotation * [-1, 1].randomElement()!))
                    .offset(self.offsets[number])
                    .animation(.spring())
                }
                Text("Score: \(score)")
                    .foregroundColor(.white)
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)."), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
                
                self.clearButtonStates()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])."
        }

        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func randomOffset() -> CGSize {
        let screenSize = UIScreen.main.bounds.size

        let angle = Double.random(in: 0...360)
        
        let x = sin(angle) * (Double(screenSize.width) + 200)
        let y = cos(angle) * (Double(screenSize.height) + 200)
        return CGSize(width: x, height: y)
    }
    
    func setButtonStates(correctAnswer: Bool) {
        if correctAnswer {
            correctYRotation = 360
            incorrectOpacity = 0.25
        } else {
            for i in 0..<offsets.count {
                offsets[i] = randomOffset()
            }
            rotation = 360
        }
    }
    
    func clearButtonStates() {
        correctYRotation = 0.0
        incorrectOpacity = 1.0
        
        for i in 0..<offsets.count {
            offsets[i] = .zero
        }
        rotation = 0.0

    }
}

struct ContentView_Challenges_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_Challenges()
    }
}
