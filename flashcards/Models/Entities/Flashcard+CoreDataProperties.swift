//
//  Flashcard+CoreDataProperties.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-14.
//
//

import Foundation
import CoreData


extension Flashcard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Flashcard> {
        return NSFetchRequest<Flashcard>(entityName: "Flashcard")
    }

    @NSManaged public var backDescription: String?
    @NSManaged public var flashcardID: String?
    @NSManaged public var frontLabel: String?
    @NSManaged public var status: String?
    @NSManaged public var deck: Deck?
    @NSManaged public var createdAt: Date

}

extension Flashcard : Identifiable {

}
