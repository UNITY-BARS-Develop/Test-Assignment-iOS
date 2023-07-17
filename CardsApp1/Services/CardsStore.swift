//
//  CardsMock.swift
//  CardsApp1
//
//  Created by NikoS on 10.07.2023.
//

import Foundation

class CardsStore: CardsStoreProtocol {
    
    static var cards: [Card] = []
    
    func fetchCards(completionHandler: @escaping (() throws -> [Card]) -> Void) {
        completionHandler { return type(of: self).cards }
    }
    
    func createCard(cardToCreate: Card, completionHandler: @escaping (Card) -> Void) {
        type(of: self).cards.append(cardToCreate)
        completionHandler(cardToCreate)
    }
}
