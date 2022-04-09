    //
    //  Board.swift
    //  SnakesAndLadders
    //
    //  Created by Kartik Narayanan on 15/03/22.
    //

import Foundation
import UIKit

protocol BoardDelegate {
    func playerDidSomething(_ controller: Board, playerId: Int, balance: Int, text: String, currentPos: Int, newPos: Int, terminus: Int)
}

struct Board {
    private var tiles: [Tile]
    private var players: [Player]
    private var specialTiles: [SpecialTile]
    private var isGameOver: Bool = false
    private var playerCounter: Int = 0
    private var isGameWon: Bool = false

    var delegate: BoardDelegate?
    
    init() {
        tiles = [Tile]()
        players = [Player]()
        specialTiles = [SpecialTile]()
    }
    
    mutating func startNewGame() {
        isGameWon = false
        isGameOver = true
        resetBoard()
        createPlayers(name: "", token: "")
        addRandomSpecialTiles(count: 8)
        playerCounter = 0
            //    playGame()
    }
    
    private mutating func createPlayers(name: String, token: String) {
        for i in 0...AppConfig.numberofPlayers - 1 {
            players.append(Player(playerID: i, name: "Player \(i)", token: token)) //add function to get player input and
        }

        players[0].setHuman(isHuman: true)
        players[1].setHuman(isHuman: true)
        players[2].setHuman(isHuman: true)
        players[3].setHuman(isHuman: true)
    }
    
    private mutating func resetBoard() {
        tiles = [Tile]()
        players = [Player]()
        specialTiles = [SpecialTile]()
        BoardHelper.resetBoard()

        for i in 0...AppConfig.boardSize - 1 {
            tiles.append(Tile(tId: BoardHelper.getTileIdFromIndex(value: i),
                              tIndex: i))
        }
    }

    mutating private func addRandomSpecialTiles(count: Int = 0) {
        specialTiles = [SpecialTile]()
        for i in 0...(2 * count - 1) {
            var tileType: TileType
            if i < count {
                tileType = Bool.random() ? .slow : .fast
            } else {
                tileType = Bool.random() ? .snake : .ladder
            }
            let s = BoardHelper.generateSpecialTile(tileType: tileType)
            specialTiles.append(SpecialTile(index: i,
                                            start: s.start,
                                            length: s.length,
                                            tileType: tileType))
            BoardHelper.specialTileLookup[s.start] = i
        }
        Log.log(BoardHelper.specialTileLookup, level: .debug)
    }

    mutating func playTurn() {

        let currentPosition = players[playerCounter].getPosition()
        let newPosition = players[playerCounter].playerRollsDice()
        var terminus = newPosition
        let s = BoardHelper.getSpecialTileIndexFromId(newPosition)
        if s != -1 {
            let specialTile = specialTiles[s]
            terminus = players[playerCounter].ifPlayerHasComeToSpecialTile(status: specialTile.getTileType(), terminus: specialTile.getEnd())
        }

        Log.log("player \(playerCounter) current: \(currentPosition) new: \(newPosition) terminus: \(terminus)", level: .debug)
        let oldPlayerCounter = playerCounter
        if Dice.returnRollSum() != 6 {
            playerCounter = playerCounter == AppConfig.numberofPlayers - 1 ? 0 : playerCounter + 1
        }
        delegate?.playerDidSomething(self,
                                     playerId: oldPlayerCounter,
                                     balance: players[oldPlayerCounter].getBalance(),
                                     text: String("Player: \(playerCounter) to Play"),
                                     currentPos: BoardHelper.getTileIndexFromId(currentPosition),
                                     newPos: BoardHelper.getTileIndexFromId(newPosition),
                                     terminus: BoardHelper.getTileIndexFromId(terminus))
        isGameWon = newPosition == AppConfig.boardSize ? true : false
        if !players[playerCounter].getIsHuman() {
            playTurn()
        }

    }

    func getTileInfo(index: Int) -> (tileId: Int, backgroundColor: UIColor, textColor: UIColor, borderColor: UIColor) {
        return (tileId: tiles[index].tId, backgroundColor: tiles[index].tColor, textColor: tiles[index].tTextColor, borderColor: tiles[index].tTextColor)
    }
    
    func getPlayerInfo(index: Int) -> [(playerId: Int,playerImage: UIImage, playerColor: UIColor)]? {
        var returnValue = [(playerId: Int, playerImage: UIImage, playerColor: UIColor)]()
        let players = players.filter() {$0.getPosition() == BoardHelper.getTileIdFromIndex(value: index)}
        if players.isEmpty {
            return nil
        }
        players.forEach { player in
            returnValue.append((playerId: player.getId(),
                                playerImage: player.getPlayerImage(),
                                playerColor: player.getPlayerColor()))
        }
        return returnValue
    }
    
    func getSpecialTileInfo(index: Int) -> (symbol: UIImage, symbolColor: UIColor)? {
        let specialTileId = BoardHelper.getSpecialTileIndexFromId(BoardHelper.getTileIdFromIndex(value: index))
        if specialTileId != -1 {
            return specialTiles[specialTileId].getSymbolImage()
        } else {
            return nil
        }
    }

    func getPlayerName(playerId: Int) -> String {
        return players[playerId].getName()
    }

    func getPlayerBalance(playerId: Int) -> Int {
        return players[playerId].getBalance()
    }

    mutating func setPlayerName(playerId: Int, name: String) {
        players[playerId].setName(name: name)
    }

    mutating func setPlayerHuman(playerId: Int, isHuman: Bool) {
        players[playerId].setHuman(isHuman: isHuman)
    }


    func getAllowedLengths(index: Int, tileType: TileType) -> [lengthSnakeAndLadder]? {

        if let allowedSnakes = players[playerCounter].showAllowedLengthsBasedOnCost() {
            if let allowedLength = BoardHelper.showAllowedLengthsBasedOnPosition(index: index, type: tileType) {
                return allowedSnakes.count > allowedLength.count ? allowedLength : allowedSnakes
            }
            return nil
        }
        return nil
    }

    mutating func addUserDefinedSnakeAndLadder(index: Int, length: lengthSnakeAndLadder, tileType: TileType) {
        let i = specialTiles.count
        let s = SpecialTile(index: i, start: BoardHelper.getTileIdFromIndex(value: index), length: length, tileType: tileType)
        specialTiles.append(s)
        BoardHelper.specialTileLookup[s.getStart()] = i
        players[playerCounter].updateBalance(-10)
    }

}









