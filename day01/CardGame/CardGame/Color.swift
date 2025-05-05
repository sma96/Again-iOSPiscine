//
//  Color.swift
//  CardGame
//
//  Created by 마석우 on 5/6/25.
//

import Foundation

enum Color: String {
    case clubs = "clubs"
    case diamonds = "diamonds"
    case spades = "spades"
    case hearts = "hearts"
    
    static var allColor: [Color] = [.clubs, .diamonds, .spades, .hearts]
}
