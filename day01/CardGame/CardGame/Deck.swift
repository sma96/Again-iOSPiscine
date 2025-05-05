//
//  Deck.swift
//  CardGame
//
//  Created by 마석우 on 5/6/25.
//

import Foundation

class Deck: NSObject {
    static var allSpades: [Card] = Value.allValues.map({ Card(color: .spades, value: $0) })
    static var allDiamonds: [Card] = Value.allValues.map({ Card(color: .diamonds, value: $0) })
    static var allClubs: [Card] = Value.allValues.map({ Card(color: .clubs, value: $0) })
    static var allHearts: [Card] = Value.allValues.map({ Card(color: .hearts, value: $0) })
    static var allCard: [Card] = allSpades + allDiamonds + allClubs + allHearts
    
    var cards = [Card]()
    var discards = [Card]()
    var outs = [Card]()
    
    override init() {
        self.cards = Deck.allCard
    }
    
    override var description: String {
        cards.description
    }
    
    func shuffle() {
        cards.shuffle()
    }
    func draw() -> Card? {
        return cards.popLast()
    }
    
    func fold(c: Card) {
        if outs.contains(c) {
            discards.append(c)
        }
    }
}

extension Array where Element == Card {
    mutating func shuffle() {
        for i in 0..<self.count {
            self.swapAt(Int(arc4random_uniform(UInt32(self.count))), i)
        }
    }
}
