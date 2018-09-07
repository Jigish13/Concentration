//
//  ViewController.swift
//  Concentration
//
//  Created by Sneh on 07/08/18.
//  Copyright © 2018 The Gateway Corp. All rights reserved.
//

import UIKit

// Inorder to rename this class everywhere, i.e in storyboard too, do cmd + rename
class ConcentrationViewController: VCLLoggingViewController
{
    override var vclLoggingName: String{
        return "Game"
    }
    
    private lazy var game = Concentration(numberOfPairOfCards: numberOfPairOfCards) //lazy means game will be initialized when it will be used. Note: lazy cant have property observer i.e. didSet
    
    var numberOfPairOfCards: Int{
        return(cardButtons.count+1) / 2 // if we have read-only prop than we can ignore get prop
    }
    
    // var flipCount: Int = 0
    // OR
    private(set) var flipCount = 0{
        didSet {
            //flipCountLabel.text = "Flips: \(flipCount)"
            updateFlipCountLabel() //means after every update call the function
        }
    }
    // didSet is property observer
    
    private func updateFlipCountLabel(){
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : UIColor.black
        ]
        let attributedString = NSAttributedString(string: traitCollection.verticalSizeClass == .compact ? "Flips\n\(flipCount)" : "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    
    //Whenever we change orintation, our size class change, so call this method
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateFlipCountLabel() //Bcoz this func depends on trait collection var so when it changes then we to update it...
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet{
            updateFlipCountLabel() //means after connection call the function
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var visibleCardButtons: [UIButton]!{
        return cardButtons?.filter { !$0.superview!.isHidden }
    }
    
    //CODE to do when we change the orientation of mob then it will re-lay its sub views out
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViewFromModel()
    }
    
    
    // MARK: Handle card touch behavior
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        if let cardNumber = visibleCardButtons.index(of: sender) {
            
            //print("cardNumber = \(cardNumber)")
            
            //flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons")
        }
        //flipCountLabel.text = "Flips: \(flipCount)" //agr btn 'New Game' hoi to code messy thai jse, so redundancy remove krva mate user didSet
        
        //Read this way: flip the card with emoji ghost on sender button
        //flipCard(withEmoji: "👻", on: sender)
    }
    
    private func updateViewFromModel(){
        // for index in 0..<cardButtons.count{}
        
        // OR
        
        // for button in cardButtons{}   // button is here UIButton coz cardButtons is array of UIButtons
        
        // OR || here cardButtons.indices returns all the index values of array
        if visibleCardButtons != nil{
            for index in visibleCardButtons.indices{
                let button = visibleCardButtons[index]
                let card = game.cards[index]
                
                if card.isFaceUp{
                    button.setTitle(emoji(for: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                }else{
                    button.setTitle("", for: UIControlState.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
                }
//                print("Looping index: \(index)")
//                if(flipCount > Int(arc4random_uniform(UInt32(128)))){
//                    exit(-1);
//                }
//                print("PASSED")
            }
        }
    }
    
    
    var theme: String? {
        didSet{
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    
    //    private var emojiChoices = ["🎃","👻","😃","😍","😎","😱","🤧","🤫","🤗"]
    
    private var emojiChoices = "🎃👻😃😍😎😱🤧🤫🤗"
    
    //    var emoji = Dictionary<Int,String>()
    //      OR
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        
        //nested-if che so comma seperated use kri skiye che
        if emoji[card] == nil, emojiChoices.count > 0 {
            // let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count))) //explicitly type-casting to unsigned int-32
            
            // USING Extension...
            // 5.arc4random ==> returns [0,5)
            //emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random) //We use remove method bcoz we wont use that emoji again
            
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        
        //Note: chosenEmoji is of type String? bcoz if emoji is not present at that index then
        // not set value or nil will be returned
        //if let chosenEmoji = emoji[card.identifier]
        
        // OR
        
        //        if emoji[card.identifier] != nil{
        //            return emoji[card.identifier]!
        //        }else{
        //         return "?"
        //        }
        
        // OR - other way to write above if-else condition
        return emoji[card] ?? "?"
    }
    
    //Removing redundancy...
    //    @IBAction func touchSecondButton(_ sender: UIButton) {
    //        flipCount += 1
    //        //flipCountLabel.text = "Flips: \(flipCount)"
    //        flipCard(withEmoji: "🎃", on: sender)
    //    }
    
    //    func flipCard(withEmoji emoji: String,on button: UIButton) {
    //        print("flipCard(withEmoji: \(emoji)") //for solving the error when pumkin card was connenct to both action methods or ViewControllers
    //        if button.currentTitle == emoji {
    //            button.setTitle("", for: UIControlState.normal)
    //            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    //        } else {
    //            button.setTitle(emoji, for: UIControlState.normal)
    //            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    //        }
    //    }
}

extension Int{
    var arc4random: Int{
        if self > 0 { return Int(arc4random_uniform(UInt32(self))) } //self is emojiChoices.count
        else if self < 0 { return -Int(arc4random_uniform(UInt32(abs(self)))) }
        else { return 0 }
    }
}

