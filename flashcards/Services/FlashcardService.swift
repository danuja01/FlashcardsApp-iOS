import CoreData

class FlashcardService {
    
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - CRUD Operations for Flashcard

    func addFlashcard(to deck: Deck, flashcardID: String, frontLabel: String, backDescription: String, status: String) {
        let newFlashcard = Flashcard(context: context)
        newFlashcard.flashcardID = flashcardID
        newFlashcard.frontLabel = frontLabel
        newFlashcard.backDescription = backDescription
        newFlashcard.status = status
        newFlashcard.createdAt = Date()  

        deck.addToFlashcards(newFlashcard)
        AppDelegate.shared.saveContext()
    }

    func deleteFlashcard(_ flashcard: Flashcard) {
        context.delete(flashcard)
        AppDelegate.shared.saveContext()
    }
}
