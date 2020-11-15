//
//  ConfettiView.swift
//  MultiplicationGame
//
//  Created by Austin Carpenter on 4/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI
import UIKit

struct ConfettiView: View {
    
    var colors = [#colorLiteral(red: 1, green: 0, blue: 0.3019607843, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1), #colorLiteral(red: 0.137254902, green: 0.9137254902, blue: 0.6784313725, alpha: 1), #colorLiteral(red: 1, green: 0.8196078431, blue: 0.3019607843, alpha: 1)]
    var images = [#imageLiteral(resourceName: "Box"), #imageLiteral(resourceName: "Triangle"), #imageLiteral(resourceName: "Circle"), #imageLiteral(resourceName: "Spiral")]

    private func generateEmitterCells() -> [CAEmitterCell] {
        Array(repeatingDifferentInstance: CAEmitterCell.init, count: 15).map{ cell in
            cell.birthRate = 10.0
            cell.lifetime = 14.0
            cell.lifetimeRange = 0
            cell.velocity = 300
            cell.velocityRange = 100
            cell.yAcceleration = 500
            cell.velocityRange = 0
            cell.emissionLongitude = .pi / 2
            cell.emissionRange = .pi * 1.5
            cell.spin = 3.5
            cell.spinRange = 0
            cell.color = colors.randomElement()!.cgColor
            cell.contents = images.randomElement()!.cgImage
            cell.scaleRange = 0.25
            cell.scale = 0.1
            return cell
        }
    }

    private func generateRandomPositionInTop(of size: CGSize, division: Int) -> CGPoint {
        return CGPoint(
            x: CGFloat.random(in: 0...size.width),
            y: CGFloat.random(in: 0...size.height/CGFloat(division))
        )
    }
    
    private func confettiView() -> UIView {
        let emitter = CAEmitterLayer()
        let view = UIView()
        view.layer.addSublayer(emitter)
        return view
    }
    
    var body: some View {
        GeometryReader { geometry in
            Wrap(self.confettiView()) {
                if let sublayers = $0.layer.sublayers, let confetti = (sublayers[0] as? CAEmitterLayer) {
                    confetti.emitterPosition = self.generateRandomPositionInTop(of: geometry.size, division: 4)
                    confetti.emitterShape = .point
                    confetti.emitterSize = CGSize(width: geometry.size.width, height: 2.0)
                    confetti.emitterCells = self.generateEmitterCells()
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(750)) {
                        confetti.emitterPosition = self.generateRandomPositionInTop(of: geometry.size, division: 4)
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(750)) {
                            confetti.birthRate = 0.0
                        }
                    }
                }
            }
        }
    }
}

struct ConfettiView_Previews: PreviewProvider {
    static var previews: some View {
        ConfettiView()
    }
}
