//
//  ListCardsInteractor.swift
//  CardsApp
//
//  Created by NikoS on 07.07.2023.
//

import Foundation

protocol ListCardsBusinessLogic {
    func fetchCards(request: ListCards.FetchCards.Request)
    func createCard()
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
    
    func createCard() {
        let cardToCreate = createRandomCard()
        
        cardsWorker.createCard(cardToCreate: cardToCreate) { (card: CardDTO?) in
            let response = ListCards.CreateCard.CreateCard.Response(card: card)
            self.presenter?.presentCreatedCard(response: response)
        }
    }
    
    private func createRandomCard() -> CardDTO {
        var randomCardString = ""
        var cardID = ""
        let cardTypes: [CardType] = [.masterCard, .visa]
        
        for _ in 1...8 {
            let randomDigit = Int.random(in: 0...9)
            cardID += String(randomDigit)
        }
        
        for _ in 1...4 {
            let randomDigit = Int.random(in: 0...9)
            randomCardString += String(randomDigit)
        }
        
        return CardDTO(id: cardID, cardNumber: "**** **** **** \(randomCardString)", paymentTypeImage: cardTypes.randomElement()!)
    }
    
    
}
