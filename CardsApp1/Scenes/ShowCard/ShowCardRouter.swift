//
//  ShowCardRouter.swift
//  CardsApp
//
//  Created by NikoS on 07.07.2023.
//

import UIKit

protocol ShowCardDataPassing {
    var dataStore: ShowCardDataStore? { get }
}

class ShowCardRouter: ShowCardDataPassing {
    
    weak var viewController: ShowCardViewController?
    var dataStore: ShowCardDataStore?
    
    func navigateToListCards(source: ShowCardViewController) {
        source.navigationController?.popViewController(animated: true)
    }
    
    
}
