//
//  CardsMock.swift
//  CardsApp1
//
//  Created by NikoS on 10.07.2023.
//

import Foundation

class CardsMock: CardsStoreProtocol {
    static var cards = [
        CardDTO(id: "1234", cardNumber: "**** **** **** 3214", paymentTypeImage: .masterCard),
        CardDTO(id: "4321", cardNumber: "**** **** **** 3135", paymentTypeImage: .visa),
        CardDTO(id: "1236", cardNumber: "**** **** **** 1754", paymentTypeImage: .masterCard),
        CardDTO(id: "6123", cardNumber: "**** **** **** 7645", paymentTypeImage: .visa),
        CardDTO(id: "6122", cardNumber: "**** **** **** 5432", paymentTypeImage: .masterCard),
        CardDTO(id: "9172", cardNumber: "**** **** **** 6234", paymentTypeImage: .visa)
    ]
    
    func fetchCards(completionHandler: @escaping (() throws -> [CardDTO]) -> Void) {
        completionHandler { return type(of: self).cards }
    }
    
    func createCard(cardToCreate: CardDTO, completionHandler: @escaping (CardDTO) -> Void) {
        type(of: self).cards.append(cardToCreate)
        completionHandler(cardToCreate)
    }
}
