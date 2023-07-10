//
//  ListCardsInteractor.swift
//  CardsApp
//
//  Created by NikoS on 07.07.2023.
//

import Foundation

protocol ListCardsBusinessLogic {
    func fetchCards(request: ListCards.FetchCards.Request)
}

protocol ListCardsDataStore {
    var cards: [CardDTO]? { get }
}

class ListCardsInteractor: ListCardsBusinessLogic, ListCardsDataStore {
    var presenter: ListCardsPresentationLogic?
    
    var cardsWorker = CardsWorker(cardsStore: CardsMock())
    var cards: [CardDTO]?
    
    func fetchCards(request: ListCards.FetchCards.Request) {
        cardsWorker.fetchCards { (cards) -> Void in
            self.cards = cards
            let response = ListCards.FetchCards.Response(cards: cards)
            self.presenter?.presentFetchedCards(response: response)
        }
    }
}
