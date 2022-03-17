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
                
        cell.myImage.image = gameSession.board.tiles[indexPath.row].tImage
        cell.myLabel.text = String(gameSession.board.tiles[indexPath.row].tId)
        cell.backgroundColor = gameSession.board.tiles[indexPath.row].tColor
        
        return cell
    }
    
        // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
}
