//
//  Dice.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 18/03/22.
//

import Foundation
import UIKit


protocol DiceDelegate {
    func getAnimateSingleDieRoll(animatedImages: [UIImage], finalImage: UIImage)
}


struct Dice {
    static private var noOfDice: Int = 1
    static private var noOfSides: Int = 6
    static private var generatedRoll: [Int] = [Int]()
    static private var animationCount: Int = 12
    static var delegate: DiceDelegate?
    
    static func create(numberOfDice: Int = 1, numberOfSides: Int = 6) {
        self.noOfDice = numberOfDice
        self.noOfSides = numberOfSides
        roll()
    }
    
    static func roll() {
        generatedRoll = [Int]()
        for _ in 0...noOfDice - 1 {
            generatedRoll.append(Int.random(in: 1...noOfSides))
        }
        delegate?.getAnimateSingleDieRoll(animatedImages: animateSingleDieRoll(), finalImage: returnFirstRollSymbol())
    }
    
    
    static func returnRollValues() -> [Int] {
        return generatedRoll
    }
    
    static func returnRollSum() -> Int {
        var diceValues = 0
        for i in 0...noOfDice - 1{
            diceValues += generatedRoll[i]
        }
        return diceValues
    }
    
    static func returnAllRollSymbols(fill: Bool = true) -> [UIImage] {
        var rollSymbols: [UIImage] = [UIImage]()
        generatedRoll.forEach { i in
            rollSymbols.append(returnFirstRollSymbol(value: i, fill: fill))
        }
        return rollSymbols
    }
    static func returnFirstRollSymbol(value: Int = generatedRoll[0], fill: Bool = true) -> UIImage {
        return UIImage(systemName: noOfSides > 6 ? String(value) + ".square" + (fill ? ".fill" : "") : "die.face." + String(value) + (fill ? ".fill" : ""))!
    }
    
    static func animateSingleDieRoll(fill: Bool = true) -> [UIImage] {
        var dieRollAnimation = [UIImage]()
        for _ in 1...animationCount {
            let i = Int.random(in: 1...noOfSides)
            dieRollAnimation.append(returnFirstRollSymbol(value: i, fill: fill))
        }
        let firstRoll = returnFirstRollSymbol()
        dieRollAnimation.append(firstRoll)

        return dieRollAnimation
    }
}

