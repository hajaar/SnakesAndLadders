//
//  ViewController.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 13/03/22.
//

import UIKit

class ViewController: UIViewController {

    var gameSession = GameSession()
    var board: Board = Board()
    let reuseIdentifier = "cell"
    @IBOutlet weak var diceImage: UIImageView!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var rollDiceButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        board = gameSession.getBoard()
        mainView.backgroundColor = Colors.boardColor
        myCollectionView.layer.borderColor = Colors.boardColor.cgColor
        myCollectionView.layer.borderWidth = 1
        myCollectionView.layer.cornerRadius = 2

    }
    @IBAction func rollDice(_ sender: UIButton) {
        rollDiceButton.isEnabled = false
        Dice.roll()
        diceImage.animationImages = Dice.animateSingleDieRoll()
        diceImage.tintColor = Colors.boardTextColor
        diceImage.animationDuration = 1.0
        diceImage.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.diceImage.stopAnimating()
            self.diceImage.image = Dice.returnFirstRollSymbol()
        }
        rollDiceButton.isEnabled = true

    }
    

}



