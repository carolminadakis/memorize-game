//
//  ViewController.swift
//  Memorize
//
//  Created by Ana Carolina Bernardes Minadakis on 10/09/21.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Memorize(numberOfPairOfCards: numberOfPairOfCards)
    
    //abaixo temos o uso de computed property (read only)
    var numberOfPairOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    //[] é o simbolo usado para Arrays
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    //Atualiza a view do jogo conforme clica nas cartas
    private func updateViewFromModel() {
        //percorre o array dos botões das cartas
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceup {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0.0192857957) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
            
        }
    }
    
    private var emojiChoices = ["🎃", "👻", "☠️", "😈", "🍬", "🍭", "😱", "🦇"]
    
    //abaixo usamos um dictionary, ele recebe um Int e retorna uma String
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }

}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

