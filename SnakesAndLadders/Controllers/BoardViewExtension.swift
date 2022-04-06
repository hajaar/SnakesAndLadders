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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            var indexPaths: [NSIndexPath] = []
            indexPaths.append(NSIndexPath(item: currentPos, section: 0))
            self.myCollectionView?.reloadItems(at: indexPaths as [IndexPath])
            indexPaths = [NSIndexPath]()
            indexPaths.append(NSIndexPath(item: newPos, section: 0))
            self.myCollectionView?.reloadItems(at: indexPaths as [IndexPath])
        }



        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if terminus > -1 {
                var indexPaths = [NSIndexPath]()
                indexPaths.append(NSIndexPath(item: terminus, section: 0))
                self.myCollectionView?.reloadItems(at: indexPaths as [IndexPath])
            }
            self.messageLabel.text = self.messageText
            self.rollDiceButton.isEnabled = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.messageLabel.text = self.messageText
            self.rollDiceButton.isEnabled = true
        }

    }
}
