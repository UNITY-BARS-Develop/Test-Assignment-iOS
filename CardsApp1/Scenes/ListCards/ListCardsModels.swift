//
//  ListCardsModels.swift
//  CardsApp
//
//  Created by NikoS on 07.07.2023.
//

import Foundation

enum ListCards {
    enum FetchCards {
        struct Request {}
        
        struct Response {
            var cards: [CardDTO]
        }
        struct ViewModel {
            struct DisplayedCard {
                var cardNumber: String
                var paymentTypeImage: String
            }
            var displayedCard: [DisplayedCard]
        }
    }
}
