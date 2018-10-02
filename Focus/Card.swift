//
//  Card.swift
//  Focus
//
//  Created by Mac on 02/10/2018.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation


// Free initializer in Struct initializes all of their variables
// Even if there is pre-initialized variables.
struct Card{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return Card.identifierFactory
    }
    
    // init tends to have both internal and external same name
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}

// Struct vs Class
// Struct = no inheritance
// Struct = value type and Class = reference type
