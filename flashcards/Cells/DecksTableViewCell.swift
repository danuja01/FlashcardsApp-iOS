//
//  DecksTableViewCell.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-10.
//

import UIKit

class DecksTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var deckStatLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var favouriteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupShadowAndRadius()
               setupSelectionBackground()
    }
    
    private func setupShadowAndRadius() {
        layer.shadowColor = UIColor(named: "Shadow")!.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 10
        layer.masksToBounds = false
        layer.cornerRadius = 30
        layer.cornerCurve = .continuous
        
        // Accessibility
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.maximumContentSizeCategory = .extraExtraLarge
        titleLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
    }
    
    private func setupSelectionBackground() {
        let selectionView = UIView(frame: CGRect.zero)
        selectionView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        selectionView.layer.cornerRadius = 30
        selectionView.layer.masksToBounds = false
        selectionView.layer.cornerCurve = .continuous
        selectedBackgroundView = selectionView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
