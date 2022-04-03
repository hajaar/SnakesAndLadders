    //
    //  Board.swift
    //  SnakesAndLadders
    //
    //  Created by Kartik Narayanan on 15/03/22.
    //

import Foundation
import UIKit

protocol BoardDelegate {
    func playerDidSomething(_ controller: Board, text: String)
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
        addRandomSpecialTiles(count: 3)
        playerCounter = 0
            //    playGame()
    }
    
    private mutating func createPlayers(name: String, token: String) {
        for i in 0...AppConfig.numberofPlayers - 1 {
            players.append(Player(playerID: i, name: name, token: token)) //add function to get player input and
        }
    }
    
    private mutating func resetBoard() {
        tiles = [Tile]()
        BoardHelper.resetBoard()
        for i in 0...AppConfig.boardSize - 1 {
            tiles.append(Tile(tId: BoardHelper.getTileIdFromIndex(value: i), tIndex: i))
        }
    }

    mutating private func addRandomSpecialTiles(count: Int = 0) {
        for i in 0...(2 * count - 1) {
            var tileType: TileType
            if i < count {
                tileType = Bool.random() ? .slow : .fast
            } else {
                tileType = Bool.random() ? .snake : .ladder
            }
            let s = SpecialTile.generateSpecialTile(tileType: tileType)
            specialTiles.append(SpecialTile(index: i, start: s.start, length: s.length, tileType: tileType ))
            BoardHelper.specialTileLookup[s.start] = i
        }
    }

    mutating func playTurn() -> (currentIndex: Int,newIndex: Int, terminusIndex: Int){
        let currentPosition = players[playerCounter].getPosition()
        let newPosition = players[playerCounter].playerRollsDice()
        let s = BoardHelper.getSpecialTileIndexFromId(newPosition)
        let terminus = s != -1 ? specialTiles[s].getEnd() : newPosition

        if Dice.returnRollSum() != 6 {
            playerCounter = playerCounter == AppConfig.numberofPlayers - 1 ? 0 : playerCounter + 1
        }
        delegate?.playerDidSomething(self, text: String("Player: \(playerCounter) to Play"))
        isGameWon = newPosition == AppConfig.boardSize ? true : false
        return (BoardHelper.getTileIndexFromId(currentPosition) , BoardHelper.getTileIndexFromId(newPosition), BoardHelper.getTileIndexFromId(terminus) )
    }
    
    func getTileInfo(index: Int) -> (tileId: Int, backgroundColor: UIColor, textColor: UIColor, borderColor: UIColor) {
        return (tileId: tiles[index].tId, backgroundColor: tiles[index].tColor, textColor: tiles[index].tTextColor, borderColor: tiles[index].tTextColor)
    }
    
    func getPlayerInfo() -> [(playerId: Int, tileIndex: Int, playerImage: UIImage, playerColor: UIColor)] {
        var returnValue = [(playerId: Int, tileIndex: Int, playerImage: UIImage, playerColor: UIColor)]()
        
        players.forEach { player in
            let tmpId = player.getId()
            let tmpTileIndex = BoardHelper.getTileIndexFromId(player.getPosition())
            let tmpPlayerImage = player.getPlayerImage()
            let tmpPlayerColor = player.getPlayerColor()
            returnValue.append((playerId: tmpId, tileIndex: tmpTileIndex, playerImage: tmpPlayerImage, playerColor: tmpPlayerColor))
        }
        return returnValue
    }
    
    func getSpecialTileInfo(index: Int) -> (symbol: UIImage?, symbolColor: UIColor) {
        return specialTiles[index].getSymbolImage()
    }
    
 
}









