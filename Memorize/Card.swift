//
//  Card.swift
//  Memorize
//
//  Created by Ana Carolina Bernardes Minadakis on 14/09/21.
//

import Foundation

struct Card {
    
    var isFaceup = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
