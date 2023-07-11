//
//  ShowCardInteractor.swift
//  CardsApp
//
//  Created by NikoS on 07.07.2023.
//

import Foundation

protocol ShowCardBusinessLogic {
    func getCard(request: ShowCard.GetCard.Request)
}

protocol ShowCardDataStore {
    var card: Card! { get set }
}

class ShowCardInteractor: ShowCardBusinessLogic, ShowCardDataStore {
    var presenter: ShowCardPresentationLogic?
    
    var card: Card!
    
    func getCard(request: ShowCard.GetCard.Request) {
        let response = ShowCard.GetCard.Response(card: card)
        presenter?.presentCard(response: response)
    }
    
    
}
