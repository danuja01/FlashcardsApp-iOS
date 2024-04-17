//
//  UICollectionViewExtensions.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-15.
//

import UIKit

extension MyDecksViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentDecks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentDeckCell", for: indexPath) as! RecentDeckCollectionViewCell
        
        let deck = recentDecks[indexPath.item]
        
        cell.titleLabel.text = deck.deckName
        cell.deckStatLabel.text = "\(deck.flashcards?.count ?? 0) TOTAL CARDS | \(deck.completedCount) COMPLETED"
        
        let completionRate = (deck.flashcards?.count ?? 0) > 0 ? Float(deck.completedCount) / Float(deck.flashcards?.count ?? 1) : 0.0
        cell.progressBar.progress = completionRate
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let selectedDeck = recentDecks[indexPath.item]
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.updateAndRefreshUI(for: selectedDeck)
        }
        performSegue(withIdentifier: "presentFlashcards", sender: selectedDeck)
    }
}
