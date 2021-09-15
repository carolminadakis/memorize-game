//
//  Memorize.swift
//  Memorize
//
//  Created by Ana Carolina Bernardes Minadakis on 14/09/21.
//

import Foundation

class Memorize {

    private(set) var cards = [Card]()
    
    //Computed Property abaixo
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceup {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceup = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int)  {
        assert(cards.indices.contains(index), "Memorize.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceup = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
            
        }
    }
    
    init(numberOfPairOfCards: Int) {
        assert(numberOfPairOfCards > 0, "Memorize.init(at: \(numberOfPairOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairOfCards {
            let card = Card()
            cards += [card, card]
        }

    }
    
    //TODO: Suffle the cards
}
