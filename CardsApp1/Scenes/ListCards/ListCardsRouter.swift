//
//  ListCardsRouter.swift
//  CardsApp
//
//  Created by NikoS on 07.07.2023.
//

import UIKit

@objc protocol ListCardsRoutingLogic {
    func routeToShowCard(segue: UIStoryboardSegue?)
}

protocol ListCardsDataPassing {
    var dataStore: ListCardsDataStore? { get }
}

class ListCardsRouter: NSObject, ListCardsRoutingLogic, ListCardsDataPassing {
    weak var viewController: ListCardsViewController?
    var dataStore: ListCardsDataStore?
    
    func routeToShowCard(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! ShowCardViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToShowCard(source: dataStore!, destination: &destinationDS)
        } else {
            let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "ShowCardViewController") as! ShowCardViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToShowCard(source: dataStore!, destination: &destinationDS)
            navigateToShowCard(source: viewController!, destination: destinationVC)
        }
    }
    
    func navigateToShowCard(source: ListCardsViewController, destination: ShowCardViewController) {
        source.show(destination, sender: nil)
    }
    
    func passDataToShowCard(source: ListCardsDataStore, destination: inout ShowCardDataStore) {
        let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
        destination.card = source.cards?[selectedRow!]
    }
}
