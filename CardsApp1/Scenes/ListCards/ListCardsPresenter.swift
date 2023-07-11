//
//  ListCardsPresenter.swift
//  CardsApp
//
//  Created by NikoS on 07.07.2023.
//

import Foundation

protocol ListCardsPresentationLogic {
    func presentFetchedCards(response: ListCards.FetchCards.Response)
    func presentCreatedCard(response: ListCards.CreateCard.CreateCard.Response)
}

class ListCardsPresenter: ListCardsPresentationLogic {
    weak var viewController: ListCardsDisplayLogic?
    
    func presentFetchedCards(response: ListCards.FetchCards.Response) {
        var displayedCards: [ListCards.FetchCards.ViewModel.DisplayedCard] = []
        for card in response.cards {
            let displayedCard = ListCards.FetchCards.ViewModel.DisplayedCard(cardNumber: card.cardNumber, paymentTypeImage: card.paymentTypeImage.cardTypeImageName)
            displayedCards.append(displayedCard)
        }
        let viewModel = ListCards.FetchCards.ViewModel(displayedCards: displayedCards)
        viewController?.displayFetchedCards(viewModel: viewModel)
    }
    
    func presentCreatedCard(response: ListCards.CreateCard.CreateCard.Response) {
        viewController?.displayCreatedCard()
    }
}
