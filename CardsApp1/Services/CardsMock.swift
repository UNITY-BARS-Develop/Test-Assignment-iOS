//
//  CardsMock.swift
//  CardsApp1
//
//  Created by NikoS on 10.07.2023.
//

import Foundation

class CardsMock: CardsStoreProtocol {
    
    static var cards: [CardDTO] = []
    
    func fetchCards(completionHandler: @escaping (() throws -> [CardDTO]) -> Void) {
        completionHandler { return type(of: self).cards }
    }
    
    func createCard(cardToCreate: CardDTO, completionHandler: @escaping (CardDTO) -> Void) {
        type(of: self).cards.append(cardToCreate)
        completionHandler(cardToCreate)
    }
}
