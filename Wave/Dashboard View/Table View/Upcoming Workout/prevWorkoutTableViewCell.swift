//
//  prevWorkoutTableViewCell.swift
//  Wave
//
//  Created by Shyam Kumar on 1/26/21.
//

import UIKit

class prevWorkoutTableViewCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backViewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 5
        backView.backgroundColor = .white
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOpacity = 0.2
        backView.layer.shadowOffset = .zero
        backView.layer.shadowRadius = 1
        
        contentView.clipsToBounds = true
        
        let prevWorkout = (Bundle.main.loadNibNamed("prevWorkout", owner: self, options: nil)![0]) as! prevWorkout
        prevWorkout.setup()
        prevWorkout.addViewToSuperview(backView)
        
    }
    
    func expand() {
        UIView.animate(withDuration: 0.2, animations: {
            self.contentView.layoutIfNeeded()
        })
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
