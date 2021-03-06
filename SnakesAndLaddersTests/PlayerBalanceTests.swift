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
        let amount = 10
        player.updateBalance(amount)
        XCTAssertEqual(player.getBalance(), amount + currentBalance)
    }

    func testBalanceIsDebited() {
        let currentBalance = 20
        player.setBalance(currentBalance)
        let amount = -9
        player.updateBalance(amount)
        XCTAssertEqual(player.getBalance(), currentBalance + amount)
    }

    func testBalanceCannotGoNegativeEvenIfDebitAmountIsGreaterThanCurrentBalance() {
        let currentBalance = 20
        player.setBalance(currentBalance)
        let amount = -2 * currentBalance
        player.updateBalance(amount)
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

    func testPlayerBalanceGetsCorrectCreditUponTraversingASnake() {
        let currentBalance = 20
        player.setBalance(currentBalance)
        let currentPosition  = 30
        player.setPosition(currentPosition)
        let turnType = TurnType.snake
        let tileType = TileType.snake
        player.setNextTurnType(turnType: turnType)
        var terminus = 40
        terminus = player.ifPlayerHasComeToSpecialTile(status: tileType, terminus: terminus)
        let amountEarned = player.calculateAmountForTilesMoved(currentPosition: currentPosition, newPosition: terminus, turnType: turnType)
        let amountCalculated = Int(Double(terminus - currentPosition) * turnType.earningMultipler)
        XCTAssertEqual(amountEarned, amountCalculated)
    }

    func testPlayerBalanceIncreasesByCorrectAmountForTraveringASnake() {
        let currentBalance = 20
        player.setBalance(currentBalance)
        let currentPosition  = 10
        player.setPosition(currentPosition)
        let tileType = TileType.snake
        var turnType = TurnType.normal
        player.setNextTurnType(turnType: turnType)
        let newPosition = player.playerRollsDice()
        var terminus = 40
        turnType = TurnType.snake
        player.setNextTurnType(turnType: turnType)
        terminus = player.ifPlayerHasComeToSpecialTile(status: tileType, terminus: terminus)
        let amountCalculated = Int(Double(terminus - newPosition) * turnType.earningMultipler) + Int(Double(newPosition - currentPosition) * TurnType.normal.earningMultipler)
        XCTAssertEqual(player.getBalance(), currentBalance + amountCalculated)
    }

    func testPlayerCanBuySnakeAndLadderOfAllValidLengthsIfTheirBalanceIsHighEnough() {
        let currentBalance = lengthSnakeAndLadder.XL.cost
        player.setBalance(currentBalance)
        let allowedLengths: [lengthSnakeAndLadder]! = player.showAllowedLengthsBasedOnCost()
        XCTAssertEqual(allowedLengths.contains(.E), false)
        XCTAssertEqual(allowedLengths.contains(.S), true)
        XCTAssertEqual(allowedLengths.contains(.M), true)
        XCTAssertEqual(allowedLengths.contains(.L), true)
        XCTAssertEqual(allowedLengths.contains(.XL), true)
    }

    func testPlayerCanBuyNoSnakeAndLadderIfTheirBalanceIsLowEnough() {
        let currentBalance = 0
        player.setBalance(currentBalance)
        let allowedLengths: [lengthSnakeAndLadder]! = player.showAllowedLengthsBasedOnCost()
        XCTAssertNil(allowedLengths)
    }

    func testPlayerCanBuySnakeAndLadderOfLengthsSOnly() {
        let currentBalance = lengthSnakeAndLadder.S.cost
        player.setBalance(currentBalance)
        let allowedLengths: [lengthSnakeAndLadder]! = player.showAllowedLengthsBasedOnCost()
        XCTAssertEqual(allowedLengths.contains(.E), false)
        XCTAssertEqual(allowedLengths.contains(.S), true)
        XCTAssertEqual(allowedLengths.contains(.M), false)
        XCTAssertEqual(allowedLengths.contains(.L), false)
        XCTAssertEqual(allowedLengths.contains(.XL), false)
    }

    func testPlayerCanBuySnakeAndLadderOfLengthsSMOnly() {
        let currentBalance = lengthSnakeAndLadder.M.cost
        player.setBalance(currentBalance)
        let allowedLengths: [lengthSnakeAndLadder]! = player.showAllowedLengthsBasedOnCost()
        XCTAssertEqual(allowedLengths.contains(.E), false)
        XCTAssertEqual(allowedLengths.contains(.S), true)
        XCTAssertEqual(allowedLengths.contains(.M), true)
        XCTAssertEqual(allowedLengths.contains(.L), false)
        XCTAssertEqual(allowedLengths.contains(.XL), false)
    }

    func testPlayerCanBuySnakeAndLadderOfLengthsSMLOnly() {
        let currentBalance = lengthSnakeAndLadder.L.cost
        player.setBalance(currentBalance)
        let allowedLengths: [lengthSnakeAndLadder]! = player.showAllowedLengthsBasedOnCost()
        XCTAssertEqual(allowedLengths.contains(.E), false)
        XCTAssertEqual(allowedLengths.contains(.S), true)
        XCTAssertEqual(allowedLengths.contains(.M), true)
        XCTAssertEqual(allowedLengths.contains(.L), true)
        XCTAssertEqual(allowedLengths.contains(.XL), false)
    }


}
