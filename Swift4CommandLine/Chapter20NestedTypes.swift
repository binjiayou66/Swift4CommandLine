//
//  Chapter20NestedTypes.swift
//  Swift4CommandLine
//
//  Created by 刘乃彬 on 2017/6/16.
//  Copyright © 2017年 刘乃彬. All rights reserved.
//

import Cocoa

class Chapter20NestedTypes: NSObject {
    static public func run() {
        // Nested Types
        // Enumerations are often created to support a specific class or structure’s functionality. Similarly, it can be convenient to define utility classes and structures purely for use within the context of a more complex type. To accomplish this, Swift enables you to define nested types, whereby you nest supporting enumerations, classes, and structures within the definition of the type they support.
        
        // (1) Nested Types in Action
        struct BlackjackCard {
            enum Suit: Character {
                case spades = "♠", hearts = "♥", diamonds = "♦", clubs = "♣"
            }
            enum Rank: Int {
                case tow = 2, three, four, five, six, seven, eight, nine, ten
                case jack, queen, king, ace
                struct Values {
                    let first: Int
                    let second: Int?
                }
                var values: Values {
                    switch self {
                    case .ace:
                        return Values(first: 1, second: 11)
                    case .jack, .queen, .king:
                        return Values(first: 10, second: nil)
                    default:
                        return Values(first: self.rawValue, second: nil)
                    }
                }
            }
            
            let suit: Suit
            let rank: Rank
            
            var description: String {
                var desc = "suit is: \(self.suit.rawValue), "
                desc += "rank is: \(rank.values.first)"
                if let second = rank.values.second {
                    desc += " or: \(second)"
                }
                return desc
            }
        }
        
        let card = BlackjackCard(suit: BlackjackCard.Suit.hearts, rank: BlackjackCard.Rank.ace)
        print(card.description)
        
        // (2) Referring to Nested Types
        // To use a nested type outside of its definition context, prefix its name with the name of the type it is nested within:
        let hearts = BlackjackCard.Suit.hearts.rawValue
        print(hearts)
        
        print("End of Chapter 20.")
    }
}
