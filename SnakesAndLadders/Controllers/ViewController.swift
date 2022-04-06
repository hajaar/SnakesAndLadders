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
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var isHumanLabel: UILabel!
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
        isHumanLabel.isHidden = !isEdit
        chooseHumanSwitch.isHidden = !isEdit
        chooseSymbolButton.isHidden = !isEdit
        chooseColorButton.isHidden = !isEdit
        editPlayerDetailsButton.tintColor = isEdit ? AppDesign.tileColor.1 : AppDesign.tileColor.0
        playerNameText.backgroundColor = isEdit ? .white : AppDesign.boardColor
        playerNameText.textColor = isEdit ? AppDesign.tileColor.1 : AppDesign.tileColor.0
        currencyImage.tintColor = AppDesign.boardTextColor.1
        playerBalanceLabel.textColor = AppDesign.boardTextColor.0
        
    }

    func getPlayerDetails(playerId: Int) {
        playerNameText.text = board.getPlayerName(playerId: playerId)
        
    }

    

    @IBAction func changeHumanToggle(_ sender: UISwitch) {
        board.setPlayerHuman(playerId: 0, isHuman: sender.isOn)
    }

    @IBAction func chooseSymbol(_ sender: UIButton) {

    }

    @IBAction func chooseColor(_ sender: UIButton) {
    }

}



