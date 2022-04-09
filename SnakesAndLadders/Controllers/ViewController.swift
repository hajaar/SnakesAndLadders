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


    @IBOutlet var playerNameText: [UITextField]!
    @IBOutlet var currencyImages: [UIImageView]!
    @IBOutlet weak var humanOrComp: UISegmentedControl!
    @IBOutlet weak var chooseSymbolButton: UIButton!
    @IBOutlet weak var chooseColorButton: UIButton!
    @IBOutlet var playerBalanceLabel: [UILabel]!
    
    @IBOutlet var editPlayersButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        board.delegate = self
        Dice.delegate = self

        Dice.roll()
        diceImage.image = Dice.returnFirstRollSymbol()

        board.startNewGame()
        initialUISetup()

    }
    @IBAction func rollDice(_ sender: UIButton) {
        board.playTurn()
    }

    @IBAction func startNewGameButton(_ sender: UIButton) {
        board.startNewGame()
        myCollectionView.reloadData()
    }

    @IBAction func editPlayerDetails(_ sender: UIButton) {
        togglePlayerDetailFields(isEdit: shouldEdit, playerId: sender.tag - 1)
        shouldEdit.toggle()
        board.setPlayerName(playerId: sender.tag - 1, name: playerNameText[sender.tag - 1].text!)

    }

    func togglePlayerDetailFields(isEdit: Bool, playerId: Int) {

        playerNameText[playerId].isEnabled = isEdit
        playerNameText[playerId].backgroundColor = isEdit ? AppDesign.boardTextColor.1 : AppDesign.boardColor
        playerNameText[playerId].textColor = isEdit ? AppDesign.tileColor.1 : AppDesign.tileColor.0


        humanOrComp.isEnabled = isEdit
        chooseSymbolButton.isEnabled = isEdit
        chooseColorButton.isEnabled = isEdit

        editPlayersButtons[playerId].tintColor = isEdit ? AppDesign.tileColor.1 : AppDesign.tileColor.0

    }

    func getPlayerDetails(playerId: Int) {
        playerNameText[playerId].text = board.getPlayerName(playerId: playerId)
    }

    @IBAction func chooseHumanOrComp(_ sender: UISegmentedControl) {
        board.setPlayerHuman(playerId: 0, isHuman: sender.selectedSegmentIndex == 0 ? true : false )
    }
    

    @IBAction func chooseSymbol(_ sender: UIButton) {

    }

    @IBAction func chooseColor(_ sender: UIButton) {
    }

    func initialUISetup() {
   //     mainView.backgroundColor = AppDesign.boardColor
        assignbackground(v: mainView)
        myCollectionView.layer.borderColor = AppDesign.tileBorderColor.cgColor
        myCollectionView.layer.borderWidth = 1
        myCollectionView.layer.cornerRadius = 2

        for i in 0...3 {
        togglePlayerDetailFields(isEdit: shouldEdit, playerId: i)
        }
        diceImage.tintColor = AppDesign.diceColor

        currencyImages.forEach { c in
            c.tintColor = AppDesign.boardTextColor.1
        }

        playerBalanceLabel.forEach { u in
            u.textColor = AppDesign.boardTextColor.0
        }

        editPlayersButtons.forEach { b in
            b.tintColor = AppDesign.tileColor.1
        }


        var i = 0
        playerNameText.forEach { p in
            p.backgroundColor = AppDesign.boardColor
            p.textColor = AppDesign.tileColor.0
            p.clipsToBounds = true
            p.layer.cornerRadius = 20
            getPlayerDetails(playerId: i)
            i += 1
        }


        humanOrComp.selectedSegmentTintColor = AppDesign.ladderColor
        humanOrComp.backgroundColor = AppDesign.snakeColor

        rollDiceButton.backgroundColor = AppDesign.diceColor
        rollDiceButton.layer.cornerRadius = 30
        rollDiceButton.tintColor = .white

    }


    func assignbackground(v: UIView){
        let background = UIImage(named: "space")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = false
        imageView.image = background
        imageView.center = v.center
        v.addSubview(imageView)
        v.sendSubviewToBack(imageView)
    }
}



