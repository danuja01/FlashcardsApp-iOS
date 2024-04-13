//
//  FlashcardService.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-14.
//
import CoreData

class FlashcardService {
    
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func createFlashcard(deck: Deck, frontLabel: String, backDescription: String, status: String) {
        let newFlashcard = Flashcard(context: context)
        newFlashcard.flashcardID = UUID().uuidString
        newFlashcard.frontLabel = frontLabel
        newFlashcard.backDescription = backDescription
        newFlashcard.status = status
        deck.addToFlashcards(newFlashcard)
        saveContext()
    }

    func deleteFlashcard(_ flashcard: Flashcard) {
        context.delete(flashcard)
        saveContext()
    }

    // Add more flashcard-specific methods as needed

    private func saveContext() {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
