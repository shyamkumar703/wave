//
//  exerciseTableViewCell.swift
//  Wave
//
//  Created by Shyam Kumar on 1/29/21.
//

import UIKit

class exerciseTableViewCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var muscleGroupsStack: UIStackView!
    @IBOutlet weak var chestLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backView.layer.cornerRadius = 5
        backView.backgroundColor = .white
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOpacity = 0.2
        backView.layer.shadowOffset = .zero
        backView.layer.shadowRadius = 1
        
        self.clipsToBounds = true
        
        chestLabel.layer.masksToBounds = true
        chestLabel.layer.cornerRadius = 5
        chestLabel.backgroundColor = Colors.purple.withAlphaComponent(0.15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
