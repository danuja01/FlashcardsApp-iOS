//
//  RecentDeckCollectionViewCell.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-09.
//

import UIKit

class RecentDeckCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var overlay: UIView!
    @IBOutlet var titleLabel: UILabel!    
    @IBOutlet var deckStatLabel: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    
    let gradient = CAGradientLayer()
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        super.layoutIfNeeded()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(named: "Shadow")!.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 10
        layer.masksToBounds = false
        layer.cornerRadius = 30
        layer.cornerCurve = .continuous
        
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.colors = [
            UIColor(red: 229/255.0, green: 238/255.0, blue: 128/255.0, alpha: 1).cgColor,
            UIColor(red: 64/255.0, green: 141/255.0, blue: 213/255.0, alpha: 1).cgColor
        ]
        gradient.frame = overlay.frame
        gradient.cornerCurve = .continuous
        gradient.cornerRadius = 30
        
        overlay.layer.insertSublayer(gradient, at: 0)
        overlay.layer.cornerRadius = 30
        overlay.layer.cornerCurve = .continuous
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
