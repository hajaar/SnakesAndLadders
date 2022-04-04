    //
    //  BoardViewExtension.swift
    //  SnakesAndLadders
    //
    //  Created by Kartik Narayanan on 04/04/22.
    //

import Foundation
import UIKit

extension ViewController: BoardDelegate {


    func playerDidSomething(_ controller: Board, text: String, currentPos: Int, newPos: Int, terminus: Int) {
        messageText = text
        print("text: \(text) currentPos: \(currentPos) newPos: \(newPos) terminus: \(terminus)")
        rollDiceButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            var indexPaths: [NSIndexPath] = []
            indexPaths.append(NSIndexPath(item: currentPos, section: 0))
            self.myCollectionView?.reloadItems(at: indexPaths as [IndexPath])
            indexPaths = [NSIndexPath]()
            indexPaths.append(NSIndexPath(item: newPos, section: 0))
            self.myCollectionView?.reloadItems(at: indexPaths as [IndexPath])
            indexPaths = [NSIndexPath]()
            if terminus > -1 {
                indexPaths.append(NSIndexPath(item: terminus, section: 0))
                self.myCollectionView?.reloadItems(at: indexPaths as [IndexPath])
                indexPaths = [NSIndexPath]()
            }
            self.messageLabel.text = self.messageText
        }
        rollDiceButton.isEnabled = true
    }
}
