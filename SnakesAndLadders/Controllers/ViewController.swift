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
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = Colors.boardColor
        myCollectionView.layer.borderColor = Colors.boardColor.cgColor
        myCollectionView.layer.borderWidth = 1
        myCollectionView.layer.cornerRadius = 2
        Dice.create(numberOfDice: 6, numberOfSides: 20)
        print(Dice.returnRollValues())
        print(Dice.returnRollSum())
        print(Dice.returnRollSymbols())
        print(Dice.returnRollSymbols(fill: false))
        Dice.roll()
        print(Dice.returnRollValues())
        print(Dice.returnRollSum())
        print(Dice.returnRollSymbols())
        print(Dice.returnRollSymbols(fill: false))
    }


}



