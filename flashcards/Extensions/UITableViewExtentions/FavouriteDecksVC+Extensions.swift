//
//  FavouriteDecksVC+Extensions.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-18.
//

import UIKit

extension FavouriteDecksViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return favouriteDecks.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DecksTableCell", for: indexPath) as! DecksTableViewCell
        
        let deck = favouriteDecks[indexPath.section]
        
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
    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 5
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedDeck = favouriteDecks[indexPath.section]
        performSegue(withIdentifier: "presentFlashcards", sender: selectedDeck)
    }
}
