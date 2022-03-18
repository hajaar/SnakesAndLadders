//
//  ViewController.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 13/03/22.
//

import UIKit

class ViewController: UIViewController {

    var gameSession = GameSession()
    let reuseIdentifier = "cell"
    @IBOutlet weak var diceImage: UIImageView!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var rollDiceButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = Colors.boardColor
        myCollectionView.layer.borderColor = Colors.boardColor.cgColor
        myCollectionView.layer.borderWidth = 1
        myCollectionView.layer.cornerRadius = 2
        diceImage.tintColor = Colors.highlightTileColor
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



