//
//  CardsWorker.swift
//  CardsApp
//
//  Created by NikoS on 10.07.2023.
//

import Foundation

protocol CardsStoreProtocol {
    func fetchCards(completionHandler: @escaping (() throws -> [CardDTO]) -> Void)
    func createCard(cardToCreate: CardDTO, completionHandler: @escaping (CardDTO) -> Void)
}

class CardsWorker {
    var cardsStore: CardsStoreProtocol
    
    init(cardsStore: CardsStoreProtocol) {
        self.cardsStore = cardsStore
    }
    
    func fetchCards(completionHandler: @escaping ([CardDTO]) -> Void) {
        cardsStore.fetchCards { (cards: () throws -> [CardDTO]) -> Void in
            do {
                let cards = try cards()
                DispatchQueue.main.async {
                    completionHandler(cards)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler([])
                }
            }
        }
    }
    
    func fetchCard(id: String, completionHandler: @escaping (CardDTO?) -> Void) {
        cardsStore.fetchCards { (cards: () throws -> [CardDTO]) -> Void in
            do {
                let cards = try cards()
                DispatchQueue.main.async {
                    let card = cards.first { $0.id == id }
                    completionHandler(card)
                    
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(nil)
                }
            }
        }
    }
    
    func createCard(cardToCreate: CardDTO, completionHandler: @escaping (CardDTO) -> Void){
        cardsStore.createCard(cardToCreate: cardToCreate) { card in
            DispatchQueue.main.async {
                completionHandler(card)
            }
        }
    }
    
}
