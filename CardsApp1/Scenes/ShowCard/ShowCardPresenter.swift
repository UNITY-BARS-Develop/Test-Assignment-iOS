//
//  ShowCardPresenter.swift
//  CardsApp
//
//  Created by NikoS on 07.07.2023.
//

import UIKit

protocol ShowCardPresentationLogic {
    func presentCard(response: ShowCard.GetCard.Response)
}

class ShowCardPresenter: ShowCardPresentationLogic {
    weak var viewController: ShowCardDisplayLogic?
    
    private func formatCardNumber(_ cardNumber: String) -> String {
        let newCardNumber = "**** \(cardNumber.suffix(4))"
        return newCardNumber
    }
    
    private func cardColor(cardType: CardType) -> UIColor {
        switch cardType {
        case .visa:
            return UIColor(hexFromString: "#faaa13")
        case .masterCard:
            return UIColor(hexFromString: "#222222")
        }
    }
    
    private func textColor(cardType: CardType) -> UIColor {
        switch cardType {
        case .visa:
            return .black
        case .masterCard:
            return .white
        }
    }
    
    func presentCard(response: ShowCard.GetCard.Response) {
        let card = response.card
        let displayedCard = ShowCard.GetCard.ViewModel.DisplayedCard(
            cardNumber: formatCardNumber(card.cardNumber),
            paymentTypeImage: CardType(rawValue: card.paymentType)?.rawValue ?? "",
            color: cardColor(cardType: CardType(rawValue: card.paymentType)!),
            textColor: textColor(cardType: CardType(rawValue: card.paymentType)!)
        )
        
        let viewModel = ShowCard.GetCard.ViewModel(displayedCard: displayedCard)
        viewController?.displayCard(viewModel: viewModel)
    }
    
}

