//
//  ContentView.swift
//  Drawing
//
//  Created by Austin Carpenter on 7/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

//Challenge 1
struct Arrow: Shape {
    
    //Challenge 2
    var animatableData: CGFloat {
        get { lineWidth }
        set { lineWidth = newValue }
    }
    
    var arrowHeadPercentage: CGFloat = 0.5
    var lineWidth: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let triangleHeight = ((3 * lineWidth * sqrt(3))/2).rounded()
        let lineRect = CGRect(x: rect.midX-lineWidth/2,
                              y: triangleHeight,
                              width: lineWidth,
                              height: rect.height-triangleHeight)
        
        var arrowHead = Path()
        arrowHead.move(to: CGPoint(x: rect.midX, y: rect.minY))
        arrowHead.addLine(to: CGPoint(x: rect.midX - lineWidth * 1.5, y: triangleHeight))
        arrowHead.addLine(to: CGPoint(x: rect.midX + lineWidth * 1.5, y: triangleHeight))
        arrowHead.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        path.addRect(lineRect)
        path.addPath(arrowHead)
        
        return path
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    var startX: CGFloat = 0
    var startY: CGFloat = 0
    var endX: CGFloat = 0
    var endY: CGFloat = 0


    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.25)
                    ]), startPoint: UnitPoint.init(x: self.startX, y: self.startY), endPoint: UnitPoint.init(x: self.endX, y: self.endY)), lineWidth: 2)
            }
        }.drawingGroup()
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    
    @State private var lineWidth: CGFloat = 10.0
    @State private var colorCycle = 0.0
    @State private var startX: CGFloat = 0
    @State private var startY: CGFloat = 0
    @State private var endX: CGFloat = 1
    @State private var endY: CGFloat = 1

    var body: some View {
        VStack {
            VStack {
                Arrow(arrowHeadPercentage: 0.5, lineWidth: lineWidth)
                    .fill(Color.black, style: FillStyle(eoFill: false, antialiased: true))
                    .padding(.bottom)
                Button("Random width") {
                    withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 100.0, damping: 10, initialVelocity: 0)) {
                        self.lineWidth = CGFloat.random(in: 5...40)
                    }
                }
            }.padding()
            
            Divider()
            
            VStack {
                ColorCyclingRectangle(amount: self.colorCycle, startX: startX, startY: startY, endX: endX, endY: endY)
                    .frame(width: 200, height: 200)
                    .padding(.bottom)
                Text("Hue offset:")
                Slider(value: $colorCycle)
                HStack {
                    VStack {
                        Text("Start X:")
                        Slider(value: $startX)

                    }
                    VStack {
                        Text("Start Y:")
                        Slider(value: $startY)
                    }
                }
                HStack {
                    VStack {
                        Text("End X:")
                        Slider(value: $endX)

                    }
                    VStack {
                        Text("End Y:")
                        Slider(value: $endY)
                    }
                }
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
