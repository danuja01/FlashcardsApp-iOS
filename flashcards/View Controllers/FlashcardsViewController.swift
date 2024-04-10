//
//  FlashcardsViewController.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-10.
//

import UIKit

class FlashcardsViewController: UIViewController {
    
    var deck : Deck?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("This deck is \(String(describing: deck?.deckName))")
        // Do any additional setup after loading the view.
    }
    

}
