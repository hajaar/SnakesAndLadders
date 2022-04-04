    //
    //  ViewController.swift
    //  SnakesAndLadders
    //
    //  Created by Kartik Narayanan on 13/03/22.
    //

import UIKit

class ViewController: UIViewController {
    
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
        board.playTurn()
    }

    @IBAction func startNewGameButton(_ sender: UIButton) {
        board.startNewGame()
        myCollectionView.reloadData()
    }

    
    
}



