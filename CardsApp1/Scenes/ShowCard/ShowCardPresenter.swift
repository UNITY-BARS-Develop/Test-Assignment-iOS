//
//  ShowCardPresenter.swift
//  CardsApp
//
//  Created by NikoS on 07.07.2023.
//

import UIKit

protocol ShowCardPresentationLogic {
    func presentCard(response: ShowCard.GetCard.Response)
}

class ShowCardPresenter: ShowCardPresentationLogic {
    weak var viewController: ShowCardDisplayLogic?
    
    private func formatCardNumber(_ cardNumber: String) -> String {
        let newCardNumber = "**** \(cardNumber.suffix(4))"
        return newCardNumber
    }
    
    private func cardColor(cardType: CardType) -> UIColor {
        switch cardType {
        case .visa:
            return UIColor(hexFromString: "#faaa13")
        case .masterCard:
            return UIColor(hexFromString: "#222222")
        }
    }
    
    private func textColor(cardType: CardType) -> UIColor {
        switch cardType {
        case .visa:
            return .black
        case .masterCard:
            return .white
        }
    }
    
    func presentCard(response: ShowCard.GetCard.Response) {
        let card = response.card
        let displayedCard = ShowCard.GetCard.ViewModel.DisplayedCard(
            cardNumber: formatCardNumber(card.cardNumber),
            paymentTypeImage: card.paymentTypeImage.cardTypeImageName, color: cardColor(cardType: card.paymentTypeImage), textColor: textColor(cardType: card.paymentTypeImage)
        )
        
        let viewModel = ShowCard.GetCard.ViewModel(displayedCard: displayedCard)
        viewController?.displayCard(viewModel: viewModel)
    }
    
}

extension UIColor {
    convenience init(hexFromString: String, alpha:CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count == 6 {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
