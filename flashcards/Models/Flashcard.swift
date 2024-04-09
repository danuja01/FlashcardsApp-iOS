//
//  Flashcards.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-09.
//

import Foundation

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
