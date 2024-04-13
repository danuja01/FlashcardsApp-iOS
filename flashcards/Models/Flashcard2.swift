//
//  Flashcards.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-09.
//

import UIKit

struct Flashcard2 {
    var flashcardID: String
    var frontLabel: String
    var backDescription: String
    var status: Status
    
    enum Status: String, Codable {
        case pending = "pending"
        case completed = "completed"
    }
}


let sampleFlashcards = [
    Flashcard2(
        flashcardID: "fc001",
        frontLabel: "What is the capital of France?",
        backDescription: "The capital of France is Paris, which is also the largest city in France and has been a major cultural and economic center since the Middle Ages.",
        status: .completed
    ),
    Flashcard2(
        flashcardID: "fc002",
        frontLabel: "What does DNA stand for?",
        backDescription: "DNA stands for Deoxyribonucleic Acid. It is the molecule that carries genetic instructions used in the growth, development, functioning, and reproduction of all known organisms.",
        status: .completed
    ),
    Flashcard2(
        flashcardID: "fc003",
        frontLabel: "Who wrote 'To Kill a Mockingbird'?",
        backDescription: "Harper Lee wrote 'To Kill a Mockingbird.' It is a novel published in 1960 that became a classic of modern American literature, dealing with serious issues such as racial injustice in a subtle way.",
        status: .completed
    ),
    Flashcard2(
        flashcardID: "fc004",
        frontLabel: "What is the boiling point of water?",
        backDescription: "The boiling point of water is 100 degrees Celsius at standard atmospheric pressure. This is the temperature at which water changes from its liquid form to vapor.",
        status: .pending
    ),
    Flashcard2(
        flashcardID: "fc005",
        frontLabel: "What is the chemical symbol for gold?",
        backDescription: "The chemical symbol for gold is Au, from the Latin 'aurum' which was the historical term used by the Romans. Gold is a chemical element with atomic number 79.",
        status: .pending
    )
]

