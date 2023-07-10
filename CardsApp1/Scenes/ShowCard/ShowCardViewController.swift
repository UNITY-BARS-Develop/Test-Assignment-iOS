//
//  ShowCardViewController.swift
//  CardsApp
//
//  Created by NikoS on 07.07.2023.
//

import UIKit

protocol ShowCardDisplayLogic: AnyObject {
    func displayCard(viewModel: ShowCard.GetCard.ViewModel)
}

class ShowCardViewController: UIViewController, ShowCardDisplayLogic {
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardView: UIView!
    
    var interactor: ShowCardBusinessLogic?
    var router: (NSObjectProtocol & ShowCardDataPassing)?
    
    func displayCard(viewModel: ShowCard.GetCard.ViewModel) {
        let displayedCard = viewModel.displayedCard
        
        cardView.layer.cornerRadius = 20.0
        cardView.backgroundColor = displayedCard.color
        cardNumberLabel.textColor = displayedCard.textColor
        cardNumberLabel.text = displayedCard.cardNumber
        cardImageView.image = UIImage(named: displayedCard.paymentTypeImage)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCard()
    }
    
    func getCard() {
        let request = ShowCard.GetCard.Request()
        interactor?.getCard(request: request)
    }
    
    private func setup() {
        let viewController = self
        let interactor = ShowCardInteractor()
        let presenter = ShowCardPresenter()
        let router = ShowCardRouter()
        viewController.interactor = interactor
        viewController.router = router as? any ShowCardDataPassing & NSObjectProtocol
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

