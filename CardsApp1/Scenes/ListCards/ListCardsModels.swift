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
            var cards: [Card]
        }
        struct ViewModel {
            struct DisplayedCard {
                var cardNumber: String
                var paymentTypeImage: String
            }
            var displayedCards: [DisplayedCard]
        }
    }
    
    enum CreateCard {
        struct CreatedCard {
            var cardNumber: String
            var cardType: String
        }
        
        enum CreateCard {
            struct Request {
                var createdCard: CreatedCard
            }
            struct Response {
                var card: Card?
            }
            struct ViewModel {
                var createdCard: Card?
            }
        }
    }
}
