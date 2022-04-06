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
    var shouldEdit: Bool = false

    @IBOutlet weak var diceImage: UIImageView!
    @IBOutlet weak var rollDiceButton: UIButton!
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet var mainView: UIView!

    @IBOutlet weak var editPlayerDetailsButton: UIButton!
    @IBOutlet weak var playerNameText: UITextField!
    @IBOutlet weak var playerBalanceLabel: UILabel!
    @IBOutlet weak var rupeeLabel: UILabel!
    @IBOutlet weak var chooseHumanSwitch: UISwitch!
    @IBOutlet weak var chooseSymbolButton: UIButton!
    @IBOutlet weak var chooseColorButton: UIButton!
    @IBOutlet weak var player0Stack: UIStackView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        board.delegate = self
        Dice.delegate = self
        
        mainView.backgroundColor = AppDesign.boardColor
        myCollectionView.layer.borderColor = AppDesign.tileBorderColor.cgColor
        myCollectionView.layer.borderWidth = 1
        myCollectionView.layer.cornerRadius = 2

        togglePlayerDetailFields(isEdit: shouldEdit)
        diceImage.tintColor = AppDesign.diceColor
        Dice.roll()
        diceImage.image = Dice.returnFirstRollSymbol()

        board.startNewGame()
        getPlayerDetails(playerId: 0)
        
    }
    @IBAction func rollDice(_ sender: UIButton) {
        board.playTurn()
    }

    @IBAction func startNewGameButton(_ sender: UIButton) {
        board.startNewGame()
        myCollectionView.reloadData()
    }

    @IBAction func editPlayerDetails(_ sender: UIButton) {
        togglePlayerDetailFields(isEdit: shouldEdit)
        shouldEdit.toggle()
        board.setPlayerName(playerId: 0, name: playerNameText.text!)

    }

    func togglePlayerDetailFields(isEdit: Bool) {
        playerNameText.isEnabled = isEdit
        chooseHumanSwitch.isEnabled = isEdit
        chooseSymbolButton.isEnabled = isEdit
        chooseColorButton.isEnabled = isEdit
    }

    func getPlayerDetails(playerId: Int) {
        playerNameText.text = board.getPlayerName(playerId: playerId)
        
    }

    

    @IBAction func changeHumanToggle(_ sender: UISwitch) {
    }

    @IBAction func chooseSymbol(_ sender: UIButton) {
    }

    @IBAction func chooseColor(_ sender: UIButton) {
    }

}



