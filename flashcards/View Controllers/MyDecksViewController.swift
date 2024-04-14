//
//  ViewController.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-09.
//

import UIKit
import Combine

class MyDecksViewController: UIViewController {
    
    @IBOutlet var cardView: CustomView!
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var recentCollectionView: UICollectionView!
    @IBOutlet var decksTabelView: UITableView!
    @IBOutlet var tableViewHeight: NSLayoutConstraint!
    @IBOutlet var scrollView: UIScrollView!
    
    
    private var tokens: Set<AnyCancellable> = []
    
    var deckService: DeckService!
    
    private var allDecks: [Deck] = []
    private var recentDecks: [Deck] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(fetchDecks), name: .didUpdateDecks, object: nil)
        
        deckService = DeckService(context: AppDelegate.getContext())
        fetchDecks()
        
        recentCollectionView.delegate = self
        recentCollectionView.dataSource = self
        recentCollectionView.layer.masksToBounds = false
        
        decksTabelView.delegate = self
        decksTabelView.dataSource = self
        decksTabelView.layer.masksToBounds = false
        decksTabelView.separatorStyle = .none
        
        decksTabelView.publisher(for: \.contentSize)
            .sink { newContentSize in
                self.tableViewHeight.constant = newContentSize.height
            }
            .store(in: &tokens)
        
        scrollView.delegate = self
        
    }
    
    @objc private func fetchDecks() {
        allDecks = deckService.fetchAllDecks()
        recentDecks = allDecks.sorted { ($0.lastViewed ?? Date.distantPast) > ($1.lastViewed ?? Date.distantPast) }.prefix(5).map { $0 }
        allDecks.sort { ($0.createdAt ?? Date.distantPast) > ($1.createdAt ?? Date.distantPast) }
        decksTabelView.reloadData()
        recentCollectionView.reloadData()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsVC = segue.destination as? FlashcardsViewController, let deck = sender as? Deck {
            detailsVC.deck = deck
        }
    }
    
    func updateAndRefreshUI(for deck: Deck) {
        deckService.updateLastViewed(for: deck)
        fetchDecks()  // Optionally, this could be optimized to not require a full fetch
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        cell.deckStatLabel.text = "\(deck.flashcards?.count ?? 0) TOTAL CARDS | \(deck.completedCount) COMPLETED"
        
        let completionRate = (deck.flashcards?.count ?? 0) > 0 ? Float(deck.completedCount) / Float(deck.flashcards?.count ?? 1) : 0.0
        cell.progressBar.progress = completionRate
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let selectedDeck = recentDecks[indexPath.item]
        updateAndRefreshUI(for: selectedDeck)
        performSegue(withIdentifier: "presentFlashcards", sender: selectedDeck)
    }
}

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

extension MyDecksViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let lastScrollYPos = scrollView.contentOffset.y
        
        let precentage = lastScrollYPos / contentHeight
        
        if precentage < 0.07 {
            self.title = "Featured"
        } else if precentage <= 0.2 {
            self.title = "Recent Decks"
        } else {
            self.title = "All Decks"
        }
    }
}
