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
    
    func fetchFavouriteDecks() {
        let allDecks = deckService.fetchAllDecks()
        favouriteDecks = allDecks.filter { $0.isFavourited }
        decksTableView.reloadData()
    }

    @objc func toggleFavourite(_ sender: UIButton) {
        let section = sender.tag
        if section < favouriteDecks.count {
            let deck = favouriteDecks[section]
            deck.isFavourited = !deck.isFavourited
            deckService.updateFavouriteStatus(for: deck, isFavourited: deck.isFavourited)

            UIView.transition(with: sender, duration: 0.3, options: .transitionCrossDissolve, animations: {
                sender.setImage(deck.isFavourited ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
            }, completion: { _ in
                self.fetchFavouriteDecks() 
            })
        }
    }
}

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
        
    }
}
