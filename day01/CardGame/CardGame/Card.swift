//
//  Card.swift
//  CardGame
//
//  Created by 마석우 on 5/6/25.
//

import Foundation

class Card: NSObject {
    var color: Color
    var value: Value
    
    
    init(color: Color, value: Value) {
        self.color = color
        self.value = value
    }
    
    override var description: String {
        return "\(color) \(value)"
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let card = object as? Card {
            return self == card
        }
        return false
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.color.rawValue == rhs.color.rawValue && lhs.value.rawValue == rhs.value.rawValue
    }
}
