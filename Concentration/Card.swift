//
//  Card.swift
//  Concentration
//
//  Created by Sneh on 08/08/18.
//  Copyright © 2018 The Gateway Corp. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    //Note: 1. If anything is hashable(means it has unique identity) then it is equable too...
    //      2. By default, Hashable implements Equatable protocol too.
    // BENEFITS of equatable:
    // 1. identifier ne aapde private banavi skiye che bcoz nd directly equate kri skiye che in Concentration Model...
    
    //This is of hashable protocol
    var hashValue: Int{return identifier}
    
    //This is of equatable protocol
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int

    //
    //    init(identifier i: Int) {
    //        identifier = i
    //    }

    // OR
    
    
    //    init(identifier: Int) {
    //        self.identifier = identifier
    //    }
    
    // After abstracting...
    private static var identifierFactory = 0
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
