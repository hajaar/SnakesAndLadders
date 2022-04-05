//
//  PlayerTests.swift
//  SnakesAndLaddersTests
//
//  Created by Kartik Narayanan on 01/04/22.
//

import XCTest
@testable import SnakesAndLadders

class PlayerTests: XCTestCase {

    var player = Player(playerID: 1, name: "Gummeemama", token: "capsule.fill")
    
    func testPlayerIsCreatedWithId() {
        let id = player.getId()
        XCTAssertEqual(id, 1)
    }

    func testPlayerIsCreatedWithName() {
        XCTAssertEqual(player.getName(), "Gummeemama")
    }
    
    func testPlayerIsCreatedWithToken() {
        XCTAssertEqual(player.getToken(), "capsule.fill")
    }

    func testPlayerHasBeenCreatedAtFirstTile() {
        XCTAssertEqual(player.getPosition(), 1)
    }

    func testPlayerIsCreatedAsHuman() {
        XCTAssertEqual(player.getIsHuman(), true)
    }

    func testPlayerHasAnImageOnCreation() {
        let tmpImage = UIImage(systemName: "\(1)\(symbolNames.playerName)")
        XCTAssertEqual(player.getPlayerImage(), tmpImage)
    }

    func testPlayerHasAColorFromAListOnCreation() {
        XCTAssertEqual(AppDesign.playerColors.contains(player.getPlayerColor()), true)
    }


    func testPlayerIsCreatedWithNormalNextTurnType() {
        XCTAssertEqual(player.getNextTurnType(), TurnType.normal)
    }

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
        let multiplier = 1
        let turnType = TurnType.normal
        let amountEarned = player.calculateAmountForTilesMoved(currentPosition: currentPosition, newPosition: newPosition, turnType: turnType)
        XCTAssertEqual(amountEarned, (newPosition - currentPosition) * multiplier)
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





    func testPlayerHasANewPosition() {
        player.setPosition(2)
        XCTAssertEqual(player.getPosition(), 2)
    }

    func testPlayerCanBeSetAsAI() {
        player.setHuman(isHuman: false)
        XCTAssertEqual(player.getIsHuman(), false)
    }

    func testPlayerReturnsUnmodifiedRollValueWhenTurnTypeIsNormal() {
        let roll = 4
        let modifiedRoll = player.nextTurnValue(roll: 4)
        XCTAssertEqual(modifiedRoll, roll)
    }
    
    func testPlayerIsSetWithFastNextTurnType() {
        player.setNextTurnType(turnType: .fast)
        XCTAssertEqual(player.getNextTurnType(), TurnType.fast)
    }
    
    func testPlayerReturnsDoubledModifiedRollValueWhenTurnTypeIsFast() {
        player.setNextTurnType(turnType: .fast)
        let modifiedRoll = player.nextTurnValue(roll: 5)
        XCTAssertEqual(modifiedRoll, 10)
    }
    
    func testPlayerReturnsRoundedDownModifiedRollValueWhenTurnTypeIsSlow() {
        player.setNextTurnType(turnType: .slow)
        let modifiedRoll = player.nextTurnValue(roll: 5)
        XCTAssertEqual(modifiedRoll, 2)

    }

    func testPlayerMovesOnRollingDice() {
        player.setNextTurnType(turnType: .normal)
        let currentPosition = 30
        player.setPosition(currentPosition)
        let newPosition = player.playerRollsDice()
        XCTAssertEqual(currentPosition + Dice.returnRollSum(), newPosition)

    }

    func testPlayerShouldNotMoveBeyondMaximumSizeOfBoardnDiceRoll() {
        player.setPosition(99)
        XCTAssertEqual(player.playerRollsDice(), 99)
    }
    
    func testPlayerMovesToEndOfSnakeOWhenTheyComeToASnakeTile() {
        let terminus = player.ifPlayerHasComeToSpecialTile(status: .snake, terminus: 50)
        XCTAssertEqual(terminus, 50)
        XCTAssertEqual(player.getPosition(), 50)
    }
    
    func testPlayerMovesToEndOfLadderOWhenTheyComeToALadderTile() {
        let terminus = player.ifPlayerHasComeToSpecialTile(status: .ladder, terminus: 50)
        XCTAssertEqual(terminus, 50)
        XCTAssertEqual(player.getPosition(), 50)
    }
    
    func testPlayerChangesNextTurnTypeWhenTheyComeToAFastTile() {
        let terminus = player.ifPlayerHasComeToSpecialTile(status: .fast, terminus: 50)
        XCTAssertEqual(terminus, -1)
        XCTAssertEqual(player.getNextTurnType(), .fast)
    }

    func testPlayerChangesNextTurnTypeWhenTheyComeToASlowTile() {
        let terminus = player.ifPlayerHasComeToSpecialTile(status: .slow, terminus: 50)
        XCTAssertEqual(terminus, -1)
        XCTAssertEqual(player.getNextTurnType(), .slow)
    }
    
    func testPlayerDoesNotChangeTerminusWhenTheyComeToANormalTile() {
        let terminus = player.ifPlayerHasComeToSpecialTile(status: .normal, terminus: -1)
        XCTAssertEqual(terminus, -1)
        XCTAssertEqual(player.getNextTurnType(), .normal)
    }
}
