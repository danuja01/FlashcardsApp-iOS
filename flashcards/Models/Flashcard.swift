//
//  Flashcards.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-09.
//

import UIKit

struct Flashcard {
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
    Flashcard(flashcardID: "fc001", frontLabel: "What is the capital of France?", backDescription: "The capital of France is Paris.", status: .completed),
    Flashcard(flashcardID: "fc002", frontLabel: "What does DNA stand for?", backDescription: "DNA stands for Deoxyribonucleic Acid.", status: .completed),
    Flashcard(flashcardID: "fc003", frontLabel: "Who wrote 'To Kill a Mockingbird'?", backDescription: "Harper Lee wrote 'To Kill a Mockingbird'.", status: .completed),
    Flashcard(flashcardID: "fc004", frontLabel: "What is the boiling point of water?", backDescription: "The boiling point of water is 100 degrees Celsius.", status: .pending),
    Flashcard(flashcardID: "fc005", frontLabel: "What is the chemical symbol for gold?", backDescription: "The chemical symbol for gold is Au.", status: .pending)
]
