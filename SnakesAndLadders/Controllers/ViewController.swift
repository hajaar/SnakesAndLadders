    //
    //  ViewController.swift
    //  SnakesAndLadders
    //
    //  Created by Kartik Narayanan on 13/03/22.
    //

import UIKit

class ViewController: UIViewController, BoardDelegate, DiceDelegate {
    func getAnimateSingleDieRoll(animatedImages: [UIImage], finalImage: UIImage) {
     /*   print("sup")
        rollDiceButton.isEnabled = false
        diceImage.animationImages = animatedImages
        diceImage.animationDuration = 1.0
        diceImage.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.diceImage.stopAnimating()
            self.diceImage.image = finalImage
        }
        rollDiceButton.isEnabled = true */
    }
    
    
    
    func playerDidSomething(_ controller: Board, text: String) {
        self.myCollectionView.reloadData()
        print(text)
        self.messageLabel.text = text
    }
    
    
    var board = Board()
    let reuseIdentifier = "cell"
    var counter: Int = 1
    
    @IBOutlet weak var diceImage: UIImageView!
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var rollDiceButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        board.delegate = self
        Dice.delegate = self
        
        mainView.backgroundColor = AppConfig.boardColor
        myCollectionView.layer.borderColor = AppConfig.boardColor.cgColor
        myCollectionView.layer.borderWidth = 1
        myCollectionView.layer.cornerRadius = 2
        
        
        diceImage.tintColor = AppConfig.diceColor
        Dice.roll()
        diceImage.image = Dice.returnFirstRollSymbol()
        board.startNewGame()
        
    }
    @IBAction func rollDice(_ sender: UIButton) {

        board.playTurn()
        rollDiceButton.isEnabled = false
        diceImage.animationImages = Dice.animateSingleDieRoll()
        diceImage.animationDuration = 1.0
        diceImage.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            self.diceImage.stopAnimating()
            self.diceImage.image = Dice.returnFirstRollSymbol()
            self.myCollectionView.reloadData()
        } 
        rollDiceButton.isEnabled = true

    }
    
    
}



