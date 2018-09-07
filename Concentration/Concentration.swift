 
   //
//  Concentration.swift
//  Concentration
//
//  Created by Sneh on 08/08/18.
//  Copyright © 2018 The Gateway Corp. All rights reserved.
//

import Foundation
 
struct Concentration{
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyOneFaceUpCard: Int? {
        get{
//            var foundIndex: Int?
//            for index in cards.indices{
//                if cards[index].isFaceUp{
//                    if foundIndex == nil{
//                        foundIndex = index
//                    } else{
//                        foundIndex = nil
//                    }
//                }
//            }
//            return foundIndex
            
            // OR
            
//            let faceUpCardIndices = cards.indices.filter { cards[$0].isFaceUp } //[0,1,2,3,4] => After filter => [2,3] ; 2,3 r faced up
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            
            // OR - by using extension Collection
            //let ch = "hello".oneAndOnly //ch = nil as string has 5 elements
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue) //set the card at index to be true if newValue i.e. indexOfOneAndOnlyOneFaceUpCard is equal to index, otherwise false
            }
        }
    }
    
    
//    func chooseCard(at index: Int){
//
//        // Code to flip the card over
//
//        //        if cards[index].isFaceUp{
//        //           cards[index].isFaceUp = false
//        //        }else{ cards[index].isFaceUp = true }
//
//        //Code to play the game
//        if !cards[index].isMatched{
//            // 3-cases : 1. No cards r face up, jus flip the card to face it up
//            //           2. 2 cards r face up, either matching or not matching, flip over that again
//            //           3. 1 card is faced up then we have to match wether it is matched or not
//            if let matchIndex = indexOfOneAndOnlyOneFaceUpCard, matchIndex != index{
//                //check if cards match
//                if cards[matchIndex].identifier == cards[index].identifier{
//                    cards[matchIndex].isMatched = true
//                    cards[index].isMatched=true
//                }
//                cards[index].isFaceUp = true
//                indexOfOneAndOnlyOneFaceUpCard = nil
//            }
//            else{
//                //either no cards or 2 cards r face up
//                for flipDownIndex in cards.indices{
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp=true
//                indexOfOneAndOnlyOneFaceUpCard=index
//            }
//        }
//
//    }
    
    
    // OR
    
    mutating func chooseCard(at index: Int){
        //ASSERTION : Comma ni pela hoi ee assert kriye aapde pn jyare ee false thse to mssg print thse...
        //cards.indices.contains(index) returns false if index chosen card is not in the indices of the card
        assert(cards.indices.contains(index),"Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyOneFaceUpCard, matchIndex != index{
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched=true
                }
                cards[index].isFaceUp = true
            }
            else{
                indexOfOneAndOnlyOneFaceUpCard=index
            }
        }
        
    }
    
    init(numberOfPairOfCards: Int) {
        assert(numberOfPairOfCards > 0,"Concentration.init(\(numberOfPairOfCards)): You must have atleast one pair of the cards")
        
        //Code to create copy of passedNumOfCards and put it in array of cards
        for _ in 1...numberOfPairOfCards{
             // _(underscore) ani jagiya pela identifier use kriyu tu
            //let card = Card(identifier: identifier) //Here we r abstracting as in this
            // class we r bother of fully initialized/implemented Card
            
            let card = Card()
            
            // Code to copy the struct :
            
            //            let matchingCard = card
            //            cards.append(card)
            //            cards.append(matchingCard)
            
            //                  OR
            
            //            cards.append(card)
            //            cards.append(card)
            
            //                  OR
            
                          cards += [card,card]
        }
        
        //TODO: Shuffle the Cards
//        for i in 0..<cards.count{
//            let rand = Int(arc4random_uniform(UInt32(cards.count)))
//            let card = cards[rand]
//            cards.remove(at: i)
//            cards.insert(card, at: i)
//        }
        
    }
 }
 
 //extending protocol Collection
 extension Collection{
    var oneAndOnly: Element? {
        return count == 1 ? first : nil //count & first are Collection's vars. So now it(oneAndOnly) can be used in String,Array,CountableRange or any other Collections
    }
 }
