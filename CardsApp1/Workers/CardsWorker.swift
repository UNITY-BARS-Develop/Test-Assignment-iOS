//
//  CardsWorker.swift
//  CardsApp
//
//  Created by NikoS on 10.07.2023.
//

import Foundation

protocol CardsStoreProtocol {
    func fetchCards(completionHandler: @escaping (() throws -> [Card]) -> Void)
    func createCard(cardToCreate: Card, completionHandler: @escaping (Card) -> Void)
}

class CardsWorker {
    let managedContext = AppDelegate.shareAppDelegate.coreDataStack.managedContext
    var cardsStore: CardsStoreProtocol
    
    
    init(cardsStore: CardsStoreProtocol) {
        self.cardsStore = cardsStore
    }
    
    func fetchCards(completionHandler: @escaping ([Card]) -> Void) {
        cardsStore.fetchCards { [weak self] (cards: () throws -> [Card]) -> Void in
            do {
                let cards = try self?.managedContext.fetch(Card.fetchRequest())
                DispatchQueue.main.async {
                    completionHandler(cards?.reversed() ?? [])
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completionHandler([])
                }
            }
        }
    }
    
    func createCard(cardToCreate: Card, completionHandler: @escaping (Card) -> Void){
        cardsStore.createCard(cardToCreate: cardToCreate) { [weak self] card in
            DispatchQueue.main.async {
                completionHandler(card)
            }
            do {
                try self?.managedContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
