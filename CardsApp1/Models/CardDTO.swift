//
//  Card.swift
//  CardsApp
//
//  Created by NikoS on 07.07.2023.
//

import Foundation

enum CardType: Int {
    case visa = 0
    case masterCard = 1
    
    var cardTypeImageName: String {
        switch self {
        case .visa:
            return "Visa"
        case .masterCard:
            return "MasterCard"
        }
    }
}

struct CardDTO: Equatable {
    var id: String
    var cardNumber: String
    var paymentTypeImage: CardType
}



