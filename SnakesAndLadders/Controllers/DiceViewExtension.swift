//
//  VCDiceExtension.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 04/04/22.
//

import Foundation
import UIKit

extension ViewController: DiceDelegate {

func getAnimateSingleDieRoll(animatedImages: [UIImage], finalImage: UIImage) {
    rollDiceButton.isEnabled = false
    diceImage.animationImages = animatedImages
    diceImage.animationDuration = 0.5
    diceImage.startAnimating()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        self.diceImage.stopAnimating()
        self.diceImage.image = finalImage
    }
    rollDiceButton.isEnabled = true
    }
}
