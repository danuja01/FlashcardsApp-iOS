//
//  MockDeckService.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-24.
//

import CoreData
@testable import flashcards

class MockDeckService: DeckService {
    
    var mockDecks: [Deck] = []
    
    override init(context: NSManagedObjectContext) {
        super.init(context: context)
    }

    
    override func createDeck(deckName: String, description: String) -> Deck {
        let deck = Deck()
        deck.deckID = UUID().uuidString
        deck.deckName = deckName
        deck.deckDescription = description
        deck.lastViewed = nil
        deck.isFavourited = false
        deck.createdAt = Date()
        mockDecks.append(deck)
        return deck
    }
    
    override func fetchAllDecks() -> [Deck] {
        return mockDecks
    }
    
    override func updateLastViewed(for deck: Deck) {
        if let index = mockDecks.firstIndex(where: { $0.deckID == deck.deckID }) {
            mockDecks[index].lastViewed = Date()
        }
    }
    
    override func updateFavouriteStatus(for deck: Deck, isFavourited: Bool) {
        if let index = mockDecks.firstIndex(where: { $0.deckID == deck.deckID }) {
            mockDecks[index].isFavourited = isFavourited
        }
    }
    
    override func updateDeck(deck: Deck, newName: String, newDescription: String) {
        if let index = mockDecks.firstIndex(where: { $0.deckID == deck.deckID }) {
            mockDecks[index].deckName = newName
            mockDecks[index].deckDescription = newDescription
        }
    }
    
    override func deleteDeck(_ deck: Deck) {
        mockDecks.removeAll { $0.deckID == deck.deckID }
    }
    
    
    
}


