//
//  ShowCardModels.swift
//  CardsApp
//
//  Created by NikoS on 07.07.2023.
//

import Foundation
import UIKit

enum ShowCard {
    enum GetCard {
        struct Request {}
        
        struct Response {
            var card: Card
        }
        
        struct ViewModel {
            struct DisplayedCard {
                var cardNumber: String
                var paymentTypeImage: String
                var color: UIColor
                var textColor: UIColor
            }
            var displayedCard: DisplayedCard
        }
    }
}
