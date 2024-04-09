//
//  ViewController.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-09.
//

import UIKit

class MyDecksViewController: UIViewController {

    @IBOutlet var cardView: CustomView!
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var recentCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recentCollectionView.delegate = self
        recentCollectionView.dataSource = self
        recentCollectionView.layer.masksToBounds = false
    }
}

extension MyDecksViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentDecks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentDeckCell", for: indexPath) as! RecentDeckCollectionViewCell
        
        let deck = recentDecks[indexPath.item]
        
        cell.titleLabel.text = deck.deckName
        cell.deckStatLabel.text = "\(deck.totalCards) TOTAL CARDS | \(deck.completedCount) COMPLETED"
            
        let completionRate = deck.totalCards > 0 ? Float(deck.completedCount) / Float(deck.totalCards) : 0.0
        cell.progressBar.progress = completionRate
        
        return cell
    }
    
    
}

