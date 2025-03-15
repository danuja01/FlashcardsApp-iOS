//
//  FlashcardsVCExtentions.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-18.
//

import UIKit

extension FlashcardsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deck?.flashcards?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlashcardCell", for: indexPath) as! FlashcardTableViewCell
        
        if let flashcards = deck?.flashcards?.allObjects as? [Flashcard] {
            let sortedFlashcards = flashcards.sorted(by: { ($0.createdAt) > ($1.createdAt) })
            let flashcard = sortedFlashcards[indexPath.row]
            
            cell.frontLabel.text = flashcard.frontLabel
            cell.backLabel.text = flashcard.backDescription
            
            if flashcard.status == "completed" {
                cell.completedIcon.isHidden = false
            } else {
                cell.completedIcon.isHidden = true
            }
            
        }
        
        return cell
    }
    
    // MARK: - Table View Delegate Methods
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true // Allows editing
    }
    
    // Add swipe actions for edit and delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Edit action
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            self.editFlashcard(at: indexPath)
            completionHandler(true)
        }
        
        // Delete action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            self.deleteFlashcard(at: indexPath)
            completionHandler(true)
        }
        
        // Semi-transparent black background
        editAction.backgroundColor = UIColor.blue.withAlphaComponent(0.6)
        deleteAction.backgroundColor = UIColor.red.withAlphaComponent(0.7)
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        configuration.performsFirstActionWithFullSwipe = false // Disable full swipe to trigger the first action automatically
        return configuration
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let flashcards = deck?.flashcards?.allObjects as? [Flashcard] else { return nil }
        let sortedFlashcards = flashcards.sorted(by: { $0.createdAt > $1.createdAt })
        let flashcard = sortedFlashcards[indexPath.row]
        
        let toggleStatusAction = UIContextualAction(style: .normal, title: flashcard.status == "completed" ? "Mark as Skipped" : "Mark as Completed") { (action, view, completionHandler) in
            flashcard.status = (flashcard.status == "completed" ? "skipped" : "completed")
            AppDelegate.shared.saveContext()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
                tableView.reloadRows(at: [indexPath], with: .fade)
                
                NotificationCenter.default.post(name: .didUpdateFlashcards, object: nil)
                NotificationCenter.default.post(name: .didUpdateDecks, object: nil)
                NotificationCenter.default.post(name: .didUpdateFavourites, object: nil)
            }
            
            
            
            completionHandler(true)
        }

        toggleStatusAction.backgroundColor = flashcard.status == "completed" ? UIColor.orange : UIColor.blue
        let configuration = UISwipeActionsConfiguration(actions: [toggleStatusAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    
    func editFlashcard(at indexPath: IndexPath) {
        if let flashcards = deck?.flashcards?.allObjects as? [Flashcard] {
            let sortedFlashcards = flashcards.sorted(by: { $0.createdAt > $1.createdAt })
            let flashcardToEdit = sortedFlashcards[indexPath.row]
            
            guard let viewController = storyboard?.instantiateViewController(withIdentifier: "AddNewFlashcardViewController") as? AddNewFlashcardViewController else { return }
            viewController.deck = deck
            viewController.flashcardToEdit = flashcardToEdit
            viewController.modalPresentationStyle = .formSheet
            
            present(viewController, animated: true, completion: nil)
        }
    }

    
    // Delete selected flashcard
    func deleteFlashcard(at indexPath: IndexPath) {
        if var flashcards = deck?.flashcards?.allObjects as? [Flashcard] {
            let sortedFlashcards = flashcards.sorted(by: { $0.createdAt > $1.createdAt })
            let flashcardToDelete = sortedFlashcards[indexPath.row]
            deck?.removeFromFlashcards(flashcardToDelete)
            AppDelegate.shared.saveContext()
            
            flashcards.remove(at: indexPath.row)
            
            flashcardsTabelView.deleteRows(at: [indexPath], with: .automatic)
            
            NotificationCenter.default.post(name: .didUpdateDecks, object: nil)
            NotificationCenter.default.post(name: .didUpdateFavourites, object: nil)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.updateUI()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

