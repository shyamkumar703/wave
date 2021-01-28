//
//  prevWorkout.swift
//  Wave
//
//  Created by Shyam Kumar on 1/26/21.
//

import UIKit

class prevWorkout: UIView {
    @IBOutlet weak var chestLabel: UILabel!
    @IBOutlet weak var shoulderLabel: UILabel!
    @IBOutlet weak var tricepLabel: UILabel!
    
    func setup() {
        let labelArr = [chestLabel, shoulderLabel, tricepLabel]
        
        for label in labelArr {
            label?.backgroundColor = Colors.purple.withAlphaComponent(0.15)
            label?.layer.masksToBounds = true
            label?.layer.cornerRadius = 5
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
