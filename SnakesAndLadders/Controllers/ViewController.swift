    //
    //  ViewController.swift
    //  SnakesAndLadders
    //
    //  Created by Kartik Narayanan on 13/03/22.
    //

import UIKit

class ViewController: UIViewController, BoardDelegate, DiceDelegate {
    func getAnimateSingleDieRoll(animatedImages: [UIImage], finalImage: UIImage) {
        rollDiceButton.isEnabled = false
        diceImage.animationImages = animatedImages
        diceImage.animationDuration = 0.75
        diceImage.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            self.diceImage.stopAnimating()
            self.diceImage.image = finalImage
        }
        rollDiceButton.isEnabled = true
    }
    
    
    
    func playerDidSomething(_ controller: Board, text: String) {
        print(text)
        messageText = text
        
    }
    
    
    var board = Board()
    let reuseIdentifier = "cell"
    var counter: Int = 1
    var messageText: String = ""
    
    @IBOutlet weak var diceImage: UIImageView!
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var rollDiceButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        board.delegate = self
        Dice.delegate = self
        
        mainView.backgroundColor = AppDesign.boardColor
        myCollectionView.layer.borderColor = AppDesign.tileBorderColor.cgColor
        myCollectionView.layer.borderWidth = 1
        myCollectionView.layer.cornerRadius = 2
        
        
        diceImage.tintColor = AppDesign.diceColor
        Dice.roll()
        diceImage.image = Dice.returnFirstRollSymbol()
        board.startNewGame()
        
    }
    @IBAction func rollDice(_ sender: UIButton) {

        let outcome = board.playTurn()
        rollDiceButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            var indexPaths: [NSIndexPath] = []
            indexPaths.append(NSIndexPath(item: outcome.currentIndex, section: 0))
            self.myCollectionView?.reloadItems(at: indexPaths as [IndexPath])
            indexPaths = [NSIndexPath]()
            indexPaths.append(NSIndexPath(item: outcome.newIndex, section: 0))
            self.myCollectionView?.reloadItems(at: indexPaths as [IndexPath])
            indexPaths = [NSIndexPath]()
            if outcome.terminusIndex > -1 {
                indexPaths.append(NSIndexPath(item: outcome.terminusIndex, section: 0))
                self.myCollectionView?.reloadItems(at: indexPaths as [IndexPath])
                indexPaths = [NSIndexPath]()
            }
            self.messageLabel.text = self.messageText
        } 
        rollDiceButton.isEnabled = true

    }
    
    
}



