//
//  FlashcardsViewController.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-10.
//

import UIKit
import Combine

class FlashcardsViewController: UIViewController {
    
    var deck: Deck?
    
    @IBOutlet var deckTitle: UILabel!
    @IBOutlet var deckStat: UILabel!
    @IBOutlet var deckDescription: UILabel!
    @IBOutlet var flashcardsTabelView: UITableView!
    @IBOutlet var tableViewHeight: NSLayoutConstraint!
    
    private var tokens: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateFlashcardData), name: .didUpdateDecks, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateFlashcardData), name: .didUpdateFlashcards, object: nil)
        
        setupTableView()
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let swippableVC = segue.destination as? SwippableViewController, let flashcards = sender as? [Flashcard] {
            swippableVC.flashcards = flashcards
        }
        
        if segue.identifier == "addFlashcardSegue", let destinationVC = segue.destination as? AddNewFlashcardViewController, let deck = sender as? Deck {
            destinationVC.deck = deck
            destinationVC.flashcardService = FlashcardService(context: AppDelegate.getContext())
            destinationVC.isCreatingNewDeck = false
        }
    }
    
    @objc private func updateFlashcardData() {
        guard let updatedDeck = try? AppDelegate.shared.persistentContainer.viewContext.existingObject(with: deck!.objectID) as? Deck else {
            return
        }
        deck = updatedDeck
        updateUI()
    }
    
    func updateUI() {
        self.deckTitle.text = deck?.deckName
        self.deckStat.text = "\(deck?.flashcards?.count ?? 0) TOTAL | \(deck?.completedCount ?? 0) COMPLETED"
        self.deckDescription.text = deck?.deckDescription
        
        flashcardsTabelView.reloadData()
    }
    
    private func setupTableView() {
        flashcardsTabelView.delegate = self
        flashcardsTabelView.dataSource = self
        flashcardsTabelView.publisher(for: \.contentSize)
            .sink { newContentSize in
                self.tableViewHeight.constant = newContentSize.height
            }
            .store(in: &tokens)
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func viewAllFlashcards(_ sender: Any) {
        if let flashcards = deck?.flashcards?.allObjects as? [Flashcard] {
            performSegue(withIdentifier: "presentSwippableCards", sender: flashcards)
        }
    }
    
    @IBAction func addFlashcardButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "addFlashcardSegue", sender: deck)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


