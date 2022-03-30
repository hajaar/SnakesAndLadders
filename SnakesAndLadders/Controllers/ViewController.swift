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
        diceImage.animationDuration = 1.0
        diceImage.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.diceImage.stopAnimating()
            self.diceImage.image = finalImage
        }
        rollDiceButton.isEnabled = true
    }
    
    
    
    func playerDidSomething(_ controller: Board, text: String) {
        self.myCollectionView.reloadData()
        print(text)
        self.messageLabel.text = text
    }
    
    
    var gameSession = GameSession()
    let reuseIdentifier = "cell"
    var counter: Int = 1
    
    @IBOutlet weak var diceImage: UIImageView!
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var rollDiceButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameSession.board.delegate = self
        Dice.delegate = self
        
        mainView.backgroundColor = AppConfig.boardColor
        myCollectionView.layer.borderColor = AppConfig.boardColor.cgColor
        myCollectionView.layer.borderWidth = 1
        myCollectionView.layer.cornerRadius = 2
        
        
        diceImage.tintColor = AppConfig.diceColor
        diceImage.image = gameSession.playTurn().2
        
        
    }
    @IBAction func rollDice(_ sender: UIButton) {
        rollDiceButton.isEnabled = false
        let diceValues: (Int, [UIImage], UIImage) = gameSession.playTurn()
        diceImage.animationImages = diceValues.1
        diceImage.animationDuration = 1.0
        diceImage.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.diceImage.stopAnimating()
            self.diceImage.image = diceValues.2
        }
        rollDiceButton.isEnabled = true
        
    }
    
    
}



