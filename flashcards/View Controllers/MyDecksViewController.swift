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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchDecks()  // Fetch and refresh the decks every time the view appears
    }
    
    @objc private func fetchDecks() {
        allDecks = deckService.fetchAllDecks()
        allDecks.sort { ($0.lastViewed ?? Date.distantPast) > ($1.lastViewed ?? Date.distantPast) }
        recentDecks = allDecks.prefix(5).map { $0 }
        decksTabelView.reloadData()
        recentCollectionView.reloadData()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsVC = segue.destination as? FlashcardsViewController, let deck = sender as? Deck {
            detailsVC.deck = deck
        }
    }
    
    
    @IBAction func pressStarBtn(_ sender: UIButton) {
        UIView.transition(with: sender, duration: 0.3, options: .transitionCrossDissolve, animations: {
            if sender.image(for: .normal) == UIImage(systemName: "star.fill") {
                sender.setImage(UIImage(systemName: "star"), for: .normal)
            } else {
                sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
            }
        }, completion: nil)
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
        
        return cell
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
