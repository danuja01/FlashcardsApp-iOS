//
//  FlashcardsViewController.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-10.
//

import UIKit
import Combine

class FlashcardsViewController: UIViewController {
    
    var deck : Deck?
    
    
    @IBOutlet var deckTitle: UILabel!
    @IBOutlet var deckStat: UILabel!
    @IBOutlet var deckDescription: UILabel!
    
    @IBOutlet var flashcardsTabelView: UITableView!
    @IBOutlet var tableViewHeight: NSLayoutConstraint!
    private var tokens: Set<AnyCancellable> = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flashcardsTabelView.delegate = self
        flashcardsTabelView.dataSource = self
        flashcardsTabelView.publisher(for: \.contentSize)
            .sink { newContentSize in
                self.tableViewHeight.constant = newContentSize.height
            }
            .store(in: &tokens)
        
//        Set the data for deck preview card
        self.deckTitle.text = deck?.deckName
        self.deckStat.text = "\(String(deck?.totalCards ?? 0)) TOTAL | \(String(deck?.completedCount ?? 0)) COMPLETED"
        self.deckDescription.text = deck?.description
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let swippableVC = segue.destination as? SwippableViewController, let cards = sender as? [Flashcard] {
            swippableVC.flashcards = cards
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func viewAllFlashcards(_ sender: Any) {
        performSegue(withIdentifier: "presentSwippableCards", sender: deck?.flashcards)
    }
}

extension FlashcardsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.deck?.flashcards.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlashcardCell", for: indexPath) as! FlashcardTableViewCell
        
        if let selectedDeck = deck {
            let selectedFlashcard = selectedDeck.flashcards[indexPath.row]
            
            cell.frontLabel.text = selectedFlashcard.frontLabel
            cell.backLabel.text = selectedFlashcard.backDescription
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
