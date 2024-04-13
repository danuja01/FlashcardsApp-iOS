//
//  Deck+CoreDataProperties.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-13.
//
//

import Foundation
import CoreData


extension Deck {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Deck> {
        return NSFetchRequest<Deck>(entityName: "Deck")
    }

    @NSManaged public var completedCount: Int16
    @NSManaged public var deckDescription: String?
    @NSManaged public var deckID: String?
    @NSManaged public var deckName: String?
    @NSManaged public var lastViewed: Date?
    @NSManaged public var totalCards: Int16
    @NSManaged public var flashcards: Flashcard?

}

extension Deck : Identifiable {

}
