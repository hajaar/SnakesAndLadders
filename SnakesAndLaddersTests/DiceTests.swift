//
//  DiceTests.swift
//  SnakesAndLaddersTests
//
//  Created by Kartik Narayanan on 31/03/22.
//

import XCTest
@testable import SnakesAndLadders

class DiceTests: XCTestCase {
    
    func testCreateOneDie() {
        Dice.create(numberOfDice: 1)
        XCTAssertEqual(Dice.returnNumberOfDice(), 1)
    }
    
    func testCreateManyDice() {
        Dice.create(numberOfDice: 3)
        XCTAssertEqual(Dice.returnNumberOfDice(), 3)
    }
    
    func testCreateSixSidedDie() {
        Dice.create(numberOfSides: 6)
        XCTAssertEqual(Dice.returnNumberOfSides(), 6)
    }
    
    func testCreateManyDiceOfSameSides() {
        Dice.create(numberOfDice: 3, numberOfSides: 12)
        XCTAssertEqual(Dice.returnNumberOfDice(), 3)
        XCTAssertEqual(Dice.returnNumberOfSides(), 12)
    }
    
    func testRollSingleDieWithSixSidesReturnsValueGreaterThanOrEqualToOne() {
        Dice.create(numberOfDice: 1, numberOfSides: 6)
        Dice.roll()
        XCTAssertGreaterThanOrEqual(Dice.returnRollSum(), 1)
    }
    
    func testRollSingleDieWithSixSidesReturnsValueLesserThanOrEqualToSix() {
        Dice.create(numberOfDice: 1, numberOfSides: 6)
        Dice.roll()
        XCTAssertLessThanOrEqual(Dice.returnRollSum(), Dice.returnNumberOfSides())
    }
    
    func testRollThreeDiceWithSixSidesReturnsValueGreaterThanOrEqualToThree() {
        Dice.create(numberOfDice: 3, numberOfSides: 6)
        Dice.roll()
        XCTAssertGreaterThanOrEqual(Dice.returnRollSum(), 3)
    }
    
    func testRollThreeDiceWithSixSidesReturnsValueLesserThanOrEqualToEighteen() {
        Dice.create(numberOfDice: 3, numberOfSides: 6)
        Dice.roll()
        XCTAssertLessThanOrEqual(Dice.returnRollSum(), 3 * Dice.returnNumberOfSides())
    }
    
    func testRollThreeDiceWithSixSidesReturnsIndividualValuesGreaterThanOrEqualToOne() {
        Dice.create(numberOfDice: 3, numberOfSides: 6)
        Dice.roll()
        let tmpRoll = Dice.returnRollValues()
        for i in 0...2 {
            XCTAssertGreaterThanOrEqual(tmpRoll[i], 1)
        }
    }
    
    func testRollThreeDiceWithSixSidesReturnsIndividualValuesLesserThanOrEqualToSix() {
        Dice.create(numberOfDice: 3, numberOfSides: 6)
        Dice.roll()
        let tmpRoll = Dice.returnRollValues()
        for i in 0...2 {
            XCTAssertLessThanOrEqual(tmpRoll[i], Dice.returnNumberOfSides())
        }
    }

    func testRollSingleDieWithSixSidesGivesSFSymbolWithDice() {
        Dice.create()
        Dice.roll()
        let rollValue = Dice.returnRollSum()
        let expectedImage = UIImage(systemName: "die.face.\(rollValue).fill")
        XCTAssertEqual(Dice.returnFirstRollSymbol(), expectedImage)
    }
    
    func testRollSingleDieWithTwelveSidesGivesSFSymbolsWithNumbers() {
        Dice.create(numberOfDice: 1, numberOfSides: 12)
        Dice.roll()
        let rollValue = Dice.returnRollSum()
        let expectedImage = UIImage(systemName: "\(rollValue).square.fill")
        XCTAssertEqual(Dice.returnFirstRollSymbol(), expectedImage)
    }


    

}
