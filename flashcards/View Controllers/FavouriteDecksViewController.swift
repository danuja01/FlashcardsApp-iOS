//
//  FavouriteDecksViewController.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-15.
//

import UIKit
import Combine

class FavouriteDecksViewController: UIViewController {

    @IBOutlet var decksTableView: UITableView!
    @IBOutlet var tableViewHeight: NSLayoutConstraint!
    @IBOutlet var scrollView: UIScrollView!
    
    
    var deckService: DeckService!
    
    var favouriteDecks: [Deck] = []
    
    private var tokens: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deckService = DeckService(context: AppDelegate.getContext())
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchFavouriteDecks), name: .didUpdateFavourites, object: nil)

        decksTableView.delegate = self
        decksTableView.dataSource = self
        decksTableView.layer.masksToBounds = false
        decksTableView.separatorStyle = .none
        
        fetchFavouriteDecks()
        
        decksTableView.publisher(for: \.contentSize)
            .sink { newContentSize in
                self.tableViewHeight.constant = newContentSize.height
            }
            .store(in: &tokens)
        
        scrollView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsVC = segue.destination as? FlashcardsViewController, let deck = sender as? Deck {
            detailsVC.deck = deck
        }
    }
    
    @objc func fetchFavouriteDecks() {
        favouriteDecks = deckService.fetchAllDecks().filter { $0.isFavourited }
        decksTableView.reloadData()
    }
    
    @objc func toggleFavourite(_ sender: UIButton) {
        let section = sender.tag
        if section < favouriteDecks.count {
            let deck = favouriteDecks[section]
            deck.isFavourited = false
            deckService.updateFavouriteStatus(for: deck, isFavourited: false)
            
            UIView.transition(with: sender, duration: 0.3, options: .transitionCrossDissolve, animations: {
                sender.setImage(UIImage(systemName: "star"), for: .normal)
            }, completion: { _ in

                self.decksTableView.beginUpdates()
                self.favouriteDecks.remove(at: section)
                self.decksTableView.deleteSections(IndexSet(integer: section), with: .fade)
                self.decksTableView.endUpdates()

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    NotificationCenter.default.post(name: .didUpdateFavourites, object: nil)
                    NotificationCenter.default.post(name: .didUpdateDecks, object: nil)
                }
            })
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

