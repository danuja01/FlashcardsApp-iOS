//
//  UIScrollViewExtensions.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-15.
//

import UIKit

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

