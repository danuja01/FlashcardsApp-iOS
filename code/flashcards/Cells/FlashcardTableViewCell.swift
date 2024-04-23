//
//  FlashcardTableViewCell.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-10.
//

import UIKit

class FlashcardTableViewCell: UITableViewCell {

    @IBOutlet var frontLabel: UILabel!
    @IBOutlet var backLabel: UILabel!
    @IBOutlet var completedIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        completedIcon.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
