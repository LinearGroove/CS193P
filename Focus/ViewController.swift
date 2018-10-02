//
//  ViewController.swift
//  Focus
//
//  Created by Mac on 02/10/2018.
//  Copyright © 2018 John. All rights reserved.
//

import UIKit


// Never change the name of ViewController
// If changed, lots of things should be changed as well

// UIViewController is inherited from UIKit
// It controls everything about UI
class ViewController: UIViewController {

    
    // Focus가 클래스이기 떄문에,
    // 모든 변수들이 초기화되면 인수가없는 init을 자동으로 가지게 된다.
    // type inference때문에 var game: Focus = Focus()로 안해도 된다.
    // lazy means it doens't actually initialize until someone uses
    // lazy counts as this var as initialized
    // lazy can't have didSet
    lazy var game = Focus(numberOfPairsOfCards: (cardButtons.count+1) / 2)
    
    // Instance variable means property
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    // Never ever copy & paste code
    
    // Outlet creates instance variable
    // ! means it doesn't have to be initialized
    @IBOutlet weak var flipCountLabel: UILabel!
    
    
    // OutletCollection is array of the things in the UI
    // [UIButton] means array of UIButtons
    // When you change cardButtons, you should use Command + Rename
    @IBOutlet var cardButtons: [UIButton]!
    
    // @IBAction is put by Xcode
    // In Swift, each parameter has each name
    // and there are external name and internal name
    // Action creates method
    
    // Int? is optional Int which has two values set or notSet.
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {
            print("No card in cardbuttons")
        }
        //let cardNumber = cardButtons.index(of: sender)!
        //print("cardNumber = \(cardNumber)")
    }
    
    
    func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
    }
    
    var emoji = [Int:String]()
    
    var emojiChoices = ["👻", "🎃", "👹", "👺"]
    
    func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0{
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        /*
        // another way to treat optional
        if emoji[card.identifier] != nil{
            return emoji[card.identifier]!
        }
        else{
            return "?"
        }
        */
        return emoji[card.identifier] ?? "?"
        
    }
}

