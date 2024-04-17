//
//  UITableViewExtensions.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-15.
//

import UIKit

extension MyDecksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allDecks.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DecksTableCell", for: indexPath) as! DecksTableViewCell
        
        let deck = allDecks[indexPath.section]
        
        cell.titleLabel.text = deck.deckName
        cell.deckStatLabel.text = "\(deck.flashcards?.count ?? 0) TOTAL CARDS | \(deck.completedCount) COMPLETED"
        cell.descriptionLabel.text = deck.deckDescription
        
        let isFavorited = deck.isFavourited
        let favoriteButtonImage = isFavorited ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        cell.favouriteBtn.setImage(favoriteButtonImage, for: .normal)

        cell.favouriteBtn.addTarget(self, action: #selector(toggleFavourite(_:)), for: .touchUpInside)
        cell.favouriteBtn.tag = indexPath.section

        return cell
    }
    
    @objc func toggleFavourite(_ sender: UIButton) {
        let section = sender.tag
        if section < allDecks.count {
            let deck = allDecks[section]
            let newFavouriteStatus = !deck.isFavourited
            deckService.updateFavouriteStatus(for: deck, isFavourited: newFavouriteStatus)

            NotificationCenter.default.post(name: .didUpdateFavourites, object: nil)
            NotificationCenter.default.post(name: .didUpdateDecks, object: nil)
            NotificationCenter.default.post(name: .didUpdateFavourites, object: nil)

            UIView.transition(with: sender, duration: 0.3, options: .transitionCrossDissolve, animations: {
                sender.setImage(newFavouriteStatus ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
            }, completion: nil)

            deck.isFavourited = newFavouriteStatus
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 5
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedDeck = allDecks[indexPath.section]
        updateAndRefreshUI(for: selectedDeck)
        performSegue(withIdentifier: "presentFlashcards", sender: selectedDeck)
    }
}

