//
//  CollectionViewExtension.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 17/03/22.
//

import Foundation
import UIKit

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - UICollectionViewDataSource protocol

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppConfig.boardSize
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell

        let t = board.getTileInfo(index: indexPath.row)
        
        cell.myLabel.text = String(t.tileId)
        cell.backgroundColor = t.backgroundColor
        cell.layer.borderColor = t.borderColor.cgColor
        cell.myLabel.textColor = t.textColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 2
        
        cell.snakeOrLadderImage.image = nil
         //same tileId as a normal tile

        if let specialTile = board.getSpecialTileInfo(index: indexPath.row) {
            cell.snakeOrLadderImage.image = specialTile.symbol
            cell.snakeOrLadderImage.tintColor = specialTile.symbolColor
        }
        
        let imageArray = [cell.myImage!, cell.myImage2!, cell.myImage3!, cell.myImage4!]
        imageArray.forEach { u in
            u.image = nil
        }

        let players = board.getPlayerInfo()
        players.forEach { player in
            if indexPath.row == player.tileIndex {
                imageArray[player.playerId].image = player.playerImage
                imageArray[player.playerId].tintColor = player.playerColor
            }
        } //optimize later so that we check for presence of player on tile and then only get the info.

        return cell
    }


    // MARK: - UICollectionViewDelegate protocol

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = AppDesign.highlightTileColor
        print("You selected cell #\(indexPath.item)!")
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let t = board.getTileInfo(index: indexPath.row)
        cell?.backgroundColor = t.backgroundColor
        print("You deselected cell #\(indexPath.item)!")
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        configureContextMenu(index: indexPath.row)
    }
    
    func configureContextMenu(index: Int) -> UIContextMenuConfiguration{
        let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            
            let edit = UIAction(title: "Edit", image: UIImage(systemName: "square.and.pencil"), identifier: nil, discoverabilityTitle: nil, state: .off) { (_) in
                print("edit button clicked")
                    //add tasks...
            }
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), identifier: nil, discoverabilityTitle: nil,attributes: .destructive, state: .off) { (_) in
                print("delete button clicked")
                    //add tasks...
            }
            return UIMenu(title: "Options", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [edit,delete])
        }
        return context
    }
}
    

