//
//  ViewController.swift
//  CardsApp1
//
//  Created by NikoS on 10.07.2023.
//

import UIKit

protocol ListCardsDisplayLogic: AnyObject {
    func displayFetchedCards(viewModel: ListCards.FetchCards.ViewModel)
    func displayCreatedCard()
}

class ListCardsViewController: UITableViewController, ListCardsDisplayLogic {
    
    var interactor: ListCardsBusinessLogic?
    var router: (NSObject & ListCardsRoutingLogic & ListCardsDataPassing)?
    private var displayedCards: [ListCards.FetchCards.ViewModel.DisplayedCard] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CardTableViewCell")
    }
    
    private func setup() {
        let viewController = self
        let interactor = ListCardsInteractor()
        let presenter = ListCardsPresenter()
        let router = ListCardsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    @IBAction func createCardButtonTapped(_ sender: Any) {
        createCard()
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: Fetching data
    
    func fetchCards() {
        let request = ListCards.FetchCards.Request()
        interactor?.fetchCards(request: request)
    }
    
    func displayFetchedCards(viewModel: ListCards.FetchCards.ViewModel) {
        displayedCards = viewModel.displayedCards
        tableView.reloadData()
    }
    
    func createCard() {
        interactor?.createCard()
    }
    
    func displayCreatedCard() {
        fetchCards()
        tableView.reloadData()
    }
    
    // MARK: Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCards()
    }
    
    // MARK: - TableView data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedCards.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayedCard = displayedCards[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CardTableViewCell
        
        cell.cardImageView.image = UIImage(named: displayedCard.paymentTypeImage)
        cell.cardNumberLabel.text = displayedCard.cardNumber
        
        return cell
    }
}

