//
//  DeckEntity+CoreDataProperties.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-14.
//
//

import Foundation
import CoreData


extension DeckEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DeckEntity> {
        return NSFetchRequest<DeckEntity>(entityName: "DeckEntity")
    }

    @NSManaged public var completedCount: Int16
    @NSManaged public var deckDescription: String?
    @NSManaged public var deckID: String?
    @NSManaged public var deckName: String?
    @NSManaged public var lastViewed: Date?
    @NSManaged public var totalCards: Int16
    @NSManaged public var flashcards: NSSet?

}

// MARK: Generated accessors for flashcards
extension DeckEntity {

    @objc(addFlashcardsObject:)
    @NSManaged public func addToFlashcards(_ value: FlashcardEntity)

    @objc(removeFlashcardsObject:)
    @NSManaged public func removeFromFlashcards(_ value: FlashcardEntity)

    @objc(addFlashcards:)
    @NSManaged public func addToFlashcards(_ values: NSSet)

    @objc(removeFlashcards:)
    @NSManaged public func removeFromFlashcards(_ values: NSSet)

}

extension DeckEntity : Identifiable {

}
