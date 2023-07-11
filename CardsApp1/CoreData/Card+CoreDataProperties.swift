//
//  Card+CoreDataProperties.swift
//  CardsApp1
//
//  Created by NikoS on 11.07.2023.
//
//

import Foundation
import CoreData

enum CardType: String, CaseIterable {
    case visa = "Visa"
    case masterCard = "MasterCard"
    
    var cardTypeImageName: String {
        switch self {
        case .visa:
            return "Visa"
        case .masterCard:
            return "MasterCard"
        }
    }
}

extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var cardNumber: String
    @NSManaged public var paymentType: String
    @NSManaged public var date: Date

}
