import UIKit

struct Deck {
    var deckID: String
    var deckName: String
    var lastViewed: Date
    var completedCount: Int
    var totalCards: Int
    var description: String
    var flashcards: [Flashcard]
}

enum Status: String {
    case pending = "pending"
    case completed = "completed"
}

let sampleDecks = [
    Deck(
        deckID: "deck001",
        deckName: "Biology Basics",
        lastViewed: Date(),
        completedCount: 12,
        totalCards: 30,
        description: "Explore the fundamentals of biological science, from cell division to the principles of photosynthesis.",
        flashcards: sampleFlashcards
    ),
    Deck(
        deckID: "deck002",
        deckName: "World History",
        lastViewed: Date(),
        completedCount: 4,
        totalCards: 20,
        description: "Dive into the key events that shaped our world, from ancient civilizations to modern conflicts.",
        flashcards: sampleFlashcards
    ),
    Deck(
        deckID: "deck003",
        deckName: "Chemistry 101",
        lastViewed: Date(),
        completedCount: 9,
        totalCards: 10,
        description: "Uncover the mysteries of chemical reactions, atomic structure, and molecular theory.",
        flashcards: sampleFlashcards
    ),
    Deck(
        deckID: "deck004",
        deckName: "Mathematics",
        lastViewed: Date(),
        completedCount: 0,
        totalCards: 2,
        description: "Grasp the fundamental concepts of mathematics, including calculus and geometric theorems.",
        flashcards : sampleFlashcards
    ),
    Deck(
        deckID: "deck005",
        deckName: "Programming Fundamentals",
        lastViewed: Date(),
        completedCount: 1,
        totalCards: 2,
        description: "Learn the basics of programming, from variables and data types to complex algorithms and recursive functions.",
        flashcards: sampleFlashcards
    )
]
