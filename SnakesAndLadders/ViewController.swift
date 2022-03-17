//
//  ViewController.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 13/03/22.
//

import UIKit

class ViewController: UIViewController {

    var board = Board()
    
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }


}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    

    
    
        // MARK: - UICollectionViewDataSource protocol
    
        // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Limits.boardSize
    }
    
        // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
        
        cell.myImage.image = board.tiles[indexPath.row].tImage
        cell.myLabel.text = String(board.tiles[indexPath.row].tId + 1)
        cell.backgroundColor = board.tiles[indexPath.row].tColor
        
        return cell
    }
    
        // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
}
