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
        return Limits.boardSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        

        
        let tmpTile = gameSession.getTileInfo(index: indexPath.row)
        
        cell.myImage.image = tmpTile.tImage
        cell.myLabel.text = String(tmpTile.tId)
        cell.backgroundColor = tmpTile.tColor
        cell.layer.borderColor = tmpTile.tBorderColor.cgColor
        cell.myLabel.textColor = Colors.boardTextColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 2
        
        return cell
    }

    
        // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            // handle tap events
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = Colors.highlightTileColor
        print("You selected cell #\(indexPath.item)!")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let tmpTile = gameSession.getTileInfo(index: indexPath.row)
        cell?.backgroundColor = tmpTile.tColor
        print("You deselected cell #\(indexPath.item)!")
    }
}
