//
//  Focus.swift
//  Focus
//
//  Created by Mac on 02/10/2018.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation

class Focus{
    
    // Whenever you make new class, think about public API
    // public API = 다른 클래스들의 사용을 허락한 메소드와 인스턴스 변수들 = how you use this class
    
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            var foundIndex: Int?
            for index in cards.indices{
                if cards[index].isFaceUp{
                    if foundIndex == nil{
                        foundIndex = index
                    }
                    else {
                        return nil
                    }
                }
            }
            
            return foundIndex
            
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int){
        // assert is ignored in AppStore
        // but it makes error when it's false in debugger
        assert(cards.indices.contains(index), "Focus.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                
                cards[index].isFaceUp = true
//                indexOfOneAndOnlyFaceUpCard = nil
            }
            else{
                // either no cards or 2 cards are face up
                /*
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                */
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
        
        /*
        if cards[index].isFaceUp {
            cards[index].isFaceUp = false
        }
        else{
            cards[index].isFaceUp = true
        }
         */
    }
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0 , "Focus.init(at: \(numberOfPairsOfCards)): you must have at leat one pair of cards")
        
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        
        // TODO: Shuffle the cards
    }
}
