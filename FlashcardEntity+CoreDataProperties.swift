//
//  FlashcardEntity+CoreDataProperties.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-14.
//
//

import Foundation
import CoreData


extension FlashcardEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlashcardEntity> {
        return NSFetchRequest<FlashcardEntity>(entityName: "FlashcardEntity")
    }

    @NSManaged public var backDescription: String?
    @NSManaged public var flashcardID: String?
    @NSManaged public var frontLabel: String?
    @NSManaged public var status: String?
    @NSManaged public var deck: DeckEntity?

}

extension FlashcardEntity : Identifiable {

}
