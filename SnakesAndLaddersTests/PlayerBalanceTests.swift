//
//  PlayerBalanceTests.swift
//  SnakesAndLaddersTests
//
//  Created by Kartik Narayanan on 05/04/22.
//

import XCTest
@testable import SnakesAndLadders

class PlayerBalanceTests: XCTestCase {
    var player = Player(playerID: 1, name: "Gummeemama", token: "capsule.fill")
    
    func testPlayerIsCreatedWithZeroBalance() {
        XCTAssertEqual(player.getBalance(), 0)
    }

    func testPlayerGetsANewBalance() {
        let currentBalance = player.getBalance()
        let newBalance = 20
        player.setBalance(newBalance)
        XCTAssertEqual(player.getBalance(), currentBalance + newBalance)
    }


    func testBalanceIsCredited() {
        let currentBalance = 20
        player.setBalance(currentBalance)
        let credit = 10
        player.creditAmount(credit)
        XCTAssertEqual(player.getBalance(), credit + currentBalance)
    }

    func testBalanceIsDebited() {
        let currentBalance = 20
        player.setBalance(currentBalance)
        let debit = 9
        player.debitAmount(debit)
        XCTAssertEqual(player.getBalance(), currentBalance - debit)
    }

    func testBalanceCannotGoNegativeEvenIfDebitAmountIsGreaterThanCurrentBalance() {
        let currentBalance = 20
        player.setBalance(currentBalance)
        let debit = 2 * currentBalance
        player.debitAmount(debit)
        XCTAssertEqual(player.getBalance(), 0)
    }

    func testPlayerGetsCreditProportionalToTheNumberOfTilesTheyMoveInOneTurn() {
        let currentPosition = 1
        let newPosition = 5
        let turnType = TurnType.normal
        let multiplier = turnType.earningMultipler

        let amountEarned = player.calculateAmountForTilesMoved(currentPosition: currentPosition, newPosition: newPosition, turnType: turnType)
        let amountCalculated = Int(Double(newPosition - currentPosition) * multiplier)
        XCTAssertEqual(amountEarned, amountCalculated)
    }

    func testPlayerBalanceIncreasesByCorrectAmountForMovingOnNormalTiles() {
        let currentBalance = 20
        player.setBalance(currentBalance)
        let currentPosition  = 10
        player.setPosition(currentPosition)
        let turnType = TurnType.normal
        player.setNextTurnType(turnType: turnType)
        let newPosition = player.playerRollsDice()
        let amountEarned = player.calculateAmountForTilesMoved(currentPosition: currentPosition, newPosition: newPosition, turnType: turnType)
        XCTAssertEqual(player.getBalance(), currentBalance + amountEarned)
    }



    func testPlayerBalanceIncreasesByCorrectAmountForMovingOnFastTiles() {
        let currentBalance = 20
        player.setBalance(currentBalance)
        let currentPosition  = 10
        player.setPosition(currentPosition)
        let turnType = TurnType.fast
        player.setNextTurnType(turnType: turnType)
        let newPosition = player.playerRollsDice()
        let amountEarned = player.calculateAmountForTilesMoved(currentPosition: currentPosition, newPosition: newPosition, turnType: turnType)
        XCTAssertEqual(player.getBalance(), currentBalance + amountEarned)
    }

    func testPlayerBalanceIncreasesByCorrectAmountForMovingOnSlowTiles() {
        let currentBalance = 20
        player.setBalance(currentBalance)
        let currentPosition  = 10
        player.setPosition(currentPosition)
        let turnType = TurnType.slow
        player.setNextTurnType(turnType: turnType)
        let newPosition = player.playerRollsDice()
        let amountEarned = player.calculateAmountForTilesMoved(currentPosition: currentPosition, newPosition: newPosition, turnType: turnType)
        XCTAssertEqual(player.getBalance(), currentBalance + amountEarned)
    }



}
