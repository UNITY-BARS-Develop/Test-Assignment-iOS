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
    var cards: [Card]? { get }
}

class ListCardsInteractor: ListCardsBusinessLogic, ListCardsDataStore {
    
    var presenter: ListCardsPresentationLogic?
    
    var cardsWorker = CardsWorker(cardsStore: CardsStore())
    var cards: [Card]?
    let managedContext = AppDelegate.shareAppDelegate.coreDataStack.managedContext
    
    func fetchCards(request: ListCards.FetchCards.Request) {
        cardsWorker.fetchCards { (cards) -> Void in
            self.cards = cards
            let response = ListCards.FetchCards.Response(cards: cards)
            self.presenter?.presentFetchedCards(response: response)
        }
    }
    
    func createCard() {
        let cardToCreate = createRandomCard()
        
        cardsWorker.createCard(cardToCreate: cardToCreate) { (card: Card?) in
            let response = ListCards.CreateCard.CreateCard.Response(card: card)
            self.presenter?.presentCreatedCard(response: response)
        }
    }
    
    private func createRandomCard() -> Card {
        var randomCardString = ""
        for _ in 1...4 {
            let randomDigit = Int.random(in: 0...9)
            randomCardString += String(randomDigit)
        }
        let newCard = Card(context: managedContext)
        newCard.cardNumber = "**** **** **** \(randomCardString)"
        let type = CardType.allCases.randomElement()!
        newCard.paymentType = type.rawValue
        newCard.date = Date()
        
        return newCard
    }
    
    
}
