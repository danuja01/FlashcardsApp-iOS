//
//  DeckService.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-14.
//
import CoreData

class DeckService {
    
    private let context: NSManagedObjectContext

    // Initialize with a managed object context
    init(context: NSManagedObjectContext) {
        self.context = context
    }

    // MARK: - CRUD Operations for Deck

    // Create a new Deck
    func createDeck(deckName: String, description: String) -> Deck {
        let newDeck = Deck(context: context)
        newDeck.deckID = UUID().uuidString
        newDeck.deckName = deckName
        newDeck.deckDescription = description
        newDeck.lastViewed = Date()
        newDeck.isFavourited = false
        newDeck.createdAt = Date()
        AppDelegate.shared.saveContext()
        return newDeck
    }

    // Fetch all Decks
    func fetchAllDecks() -> [Deck] {
        let fetchRequest: NSFetchRequest<Deck> = Deck.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching decks: \(error)")
            return []
        }
    }

    // Update a Deck's 'lastViewed' property
    func updateLastViewed(for deck: Deck) {
        deck.lastViewed = Date()
        AppDelegate.shared.saveContext()
    }
    
    // Update a Deck's 'isFavourited' property
    func updateFavouriteStatus(for deck: Deck, isFavourited: Bool) {
        deck.isFavourited = isFavourited
        AppDelegate.shared.saveContext()  // Save the updated context
    }
    
    // Update an existing Deck
    func updateDeck(deck: Deck, newName: String, newDescription: String) {
        deck.deckName = newName
        deck.deckDescription = newDescription
        deck.lastViewed = Date()  // Optionally update last viewed date on edit
        AppDelegate.shared.saveContext()
    }

    // Delete a Deck
    func deleteDeck(_ deck: Deck) {
        context.delete(deck)
        AppDelegate.shared.saveContext()
    }
}
