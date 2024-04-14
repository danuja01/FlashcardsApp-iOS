//
//  Deck+CoreDataProperties.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-14.
//
//

import Foundation
import CoreData


extension Deck {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Deck> {
        return NSFetchRequest<Deck>(entityName: "Deck")
    }
    
    @NSManaged public var deckDescription: String?
    @NSManaged public var deckID: String?
    @NSManaged public var deckName: String?
    @NSManaged public var lastViewed: Date?
    @NSManaged public var totalCards: Int16
    @NSManaged public var flashcards: NSSet?
    
    public var completedCount: Int {
        let set = flashcards as? Set<Flashcard> ?? []
        return set.filter { $0.status == "completed" }.count
    }
}

// MARK: Generated accessors for flashcards
extension Deck {
    
    @objc(addFlashcardsObject:)
    @NSManaged public func addToFlashcards(_ value: Flashcard)
    
    @objc(removeFlashcardsObject:)
    @NSManaged public func removeFromFlashcards(_ value: Flashcard)
    
    @objc(addFlashcards:)
    @NSManaged public func addToFlashcards(_ values: NSSet)
    
    @objc(removeFlashcards:)
    @NSManaged public func removeFromFlashcards(_ values: NSSet)
    
}


extension Deck : Identifiable {
    
}
