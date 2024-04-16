//
//  UITableView+LongPress.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-15.
//

import UIKit

extension MyDecksViewController {

    func setupLongPressGesture() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressRecognizer.minimumPressDuration = 0.5
        decksTabelView.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: decksTabelView)
            if let indexPath = decksTabelView.indexPathForRow(at: touchPoint) {
                presentOptions(for: indexPath)
            }
        }
    }
    
    func presentOptions(for indexPath: IndexPath) {
        let alert = UIAlertController(title: nil, message: "Deck Options", preferredStyle: .actionSheet)
        
        let editAction = UIAlertAction(title: "Edit", style: .default) { [weak self] _ in
            self?.editDeck(at: indexPath)
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.deleteDeck(at: indexPath)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(editAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func editDeck(at indexPath: IndexPath) {
        let selectedDeck = allDecks[indexPath.section]
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "AddNewDeckViewController") as? AddNewDeckViewController else { return }
        viewController.deckToEdit = selectedDeck
        viewController.modalPresentationStyle = .formSheet
        self.present(viewController, animated: true, completion: nil)
    }
    
    func deleteDeck(at indexPath: IndexPath) {
        let deck = allDecks[indexPath.section]
        deckService.deleteDeck(deck)
        allDecks.remove(at: indexPath.section)
        decksTabelView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)

        // Add a delay before refreshing the UI
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.fetchDecks()
        }
    }
}

