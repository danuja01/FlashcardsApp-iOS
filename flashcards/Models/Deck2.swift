import UIKit

struct Deck2 {
    var deckID: String
    var deckName: String
    var lastViewed: Date
    var completedCount: Int
    var totalCards: Int
    var description: String
    var flashcards: [Flashcard2]
}

//struct Deck {
//    static var deckCounter = 0  // Static counter to keep track of the number of decks
//    
//    var deckID: String
//    var deckName: String
//    var lastViewed: Date
//    var completedCount: Int
//    var totalCards: Int {
//        return flashcards.count  // Computed property to always return the count of flashcards
//    }
//    var description: String
//    var flashcards: [Flashcard]
//
//    // Custom initializer to setup defaults and manage unique IDs
//    init(deckName: String, description: String, flashcards: [Flashcard]) {
//        self.deckName = deckName
//        self.description = description
//        self.flashcards = flashcards
//        self.lastViewed = Date()  // Default to the current date
//        self.completedCount = 0   // Default completed count
//        
//        // Increment deck counter and set deck ID
//        Deck.deckCounter += 1
//        self.deckID = "deck\(Deck.deckCounter)"
//    }
//}


enum Status: String {
    case pending = "pending"
    case completed = "completed"
}

let sampleDecks = [
    Deck2(
        deckID: "deck001",
        deckName: "Biology Basics",
        lastViewed: Date(),
        completedCount: 12,
        totalCards: 30,
        description: "Explore the fundamentals of biological science, from cell division to the principles of photosynthesis.",
        flashcards: sampleFlashcards
    ),
    Deck2(
        deckID: "deck002",
        deckName: "World History",
        lastViewed: Date(),
        completedCount: 4,
        totalCards: 20,
        description: "Dive into the key events that shaped our world, from ancient civilizations to modern conflicts.",
        flashcards: sampleFlashcards
    ),
    Deck2(
        deckID: "deck003",
        deckName: "Chemistry 101",
        lastViewed: Date(),
        completedCount: 9,
        totalCards: 10,
        description: "Uncover the mysteries of chemical reactions, atomic structure, and molecular theory.",
        flashcards: sampleFlashcards
    ),
    Deck2(
        deckID: "deck004",
        deckName: "Mathematics",
        lastViewed: Date(),
        completedCount: 0,
        totalCards: 2,
        description: "Grasp the fundamental concepts of mathematics, including calculus and geometric theorems.",
        flashcards : sampleFlashcards
    ),
    Deck2(
        deckID: "deck005",
        deckName: "Programming Fundamentals",
        lastViewed: Date(),
        completedCount: 1,
        totalCards: 2,
        description: "Learn the basics of programming, from variables and data types to complex algorithms and recursive functions.",
        flashcards: sampleFlashcards
    )
]
