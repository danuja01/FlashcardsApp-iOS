import Foundation

struct Deck {
    var deckID: String
    var deckName: String
    var lastViewed: Date
    var completedCount: Int
    var totalCards: Int 
    var flashcards: [String: Flashcard]
}

let recentDecks = [
    Deck(
        deckID: "deck001",
        deckName: "Biology Basics",
        lastViewed: Date(),
        completedCount: 12,
        totalCards: 30,
        flashcards: [
            "flashcard001": Flashcard(flashcardID: "flashcard001", frontLabel: "What is mitosis?", backDescription: "Mitosis is a part of the cell cycle in which replicated chromosomes are separated into two new nuclei.", status: .completed),
            "flashcard002": Flashcard(flashcardID: "flashcard002", frontLabel: "What is photosynthesis?", backDescription: "Photosynthesis is the process used by plants, algae, and certain bacteria to harness energy from sunlight into chemical energy.", status: .completed)
        ]
    ),
    Deck(
        deckID: "deck002",
        deckName: "World History",
        lastViewed: Date(),
        completedCount: 4,
        totalCards: 20,
        flashcards: [
            "flashcard003": Flashcard(flashcardID: "flashcard003", frontLabel: "Who built the Pyramids?", backDescription: "The Pyramids were built by the ancient Egyptian civilization.", status: .pending),
            "flashcard004": Flashcard(flashcardID: "flashcard004", frontLabel: "What caused World War I?", backDescription: "World War I was primarily triggered by the assassination of Archduke Franz Ferdinand of Austria-Hungary in 1914.", status: .completed)
        ]
    ),
    Deck(
        deckID: "deck003",
        deckName: "Chemistry 101",
        lastViewed: Date(),
        completedCount: 9,
        totalCards: 10,
        flashcards: [
            "flashcard005": Flashcard(flashcardID: "flashcard005", frontLabel: "Define atom.", backDescription: "An atom is the smallest constituent unit of ordinary matter that has the properties of a chemical element.", status: .completed),
            "flashcard006": Flashcard(flashcardID: "flashcard006", frontLabel: "What is the Avogadro's number?", backDescription: "Avogadro's number is the number of constituent particles, usually atoms or molecules, that are contained in the amount of substance given by one mole.", status: .completed),
            "flashcard007": Flashcard(flashcardID: "flashcard007", frontLabel: "What is oxidation?", backDescription: "Oxidation is the loss of electrons during a reaction by a molecule, atom or ion.", status: .completed)
        ]
    ),
    Deck(
        deckID: "deck004",
        deckName: "Mathematics",
        lastViewed: Date(),
        completedCount: 0,
        totalCards: 2,
        flashcards: [
            "flashcard008": Flashcard(flashcardID: "flashcard008", frontLabel: "What is a derivative?", backDescription: "A derivative represents the rate at which a function changes as its input changes.", status: .pending),
            "flashcard009": Flashcard(flashcardID: "flashcard009", frontLabel: "Explain the Pythagorean theorem.", backDescription: "The Pythagorean theorem states that in a right triangle, the square of the hypotenuse is equal to the sum of the squares of the other two sides.", status: .pending)
        ]
    ),
    Deck(
        deckID: "deck005",
        deckName: "Programming Fundamentals",
        lastViewed: Date(),
        completedCount: 1,
        totalCards: 2,
        flashcards: [
            "flashcard010": Flashcard(flashcardID: "flashcard010", frontLabel: "What is a variable in programming?", backDescription: "A variable in programming is a storage location paired with an associated symbolic name, which contains some known or unknown quantity of information referred to as a value.", status: .completed),
            "flashcard011": Flashcard(flashcardID: "flashcard011", frontLabel: "What is recursion?", backDescription: "Recursion in computer science is a method where the solution to a problem depends on solutions to smaller instances of the same problem.", status: .completed)
        ]
    )
]
