//
//  thisWeek.swift
//  Wave
//
//  Created by Shyam Kumar on 1/25/21.
//

import UIKit

class thisWeek: UIView {
    @IBOutlet weak var workoutsThisWeek: UILabel!
    @IBOutlet weak var weightLifted: UILabel!
    @IBOutlet weak var setsLabel: UILabel!
    
    func setup() {
        setsLabel.adjustsFontSizeToFitWidth = true
        
        
        let greenStringAttributes = [NSAttributedString.Key.foregroundColor: Colors.green]
        let orangeStringAttributes = [NSAttributedString.Key.foregroundColor: Colors.orange]
        let blackStringAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let tenString = NSMutableAttributedString(string: "10", attributes: orangeStringAttributes)
        let tenString2 = NSMutableAttributedString(string: "10", attributes: orangeStringAttributes)
        let fiveString = NSMutableAttributedString(string: "5", attributes: greenStringAttributes)
        
        let chestString = NSMutableAttributedString(string: " sets of chest · ", attributes: blackStringAttributes)
        let backString = NSMutableAttributedString(string: " sets of back · ", attributes: blackStringAttributes)
        let bicepString = NSMutableAttributedString(string: " sets of biceps", attributes: blackStringAttributes)
        
        tenString.append(chestString)
        tenString.append(tenString2)
        tenString.append(backString)
        tenString.append(fiveString)
        tenString.append(bicepString)
        setsLabel.attributedText = tenString
        
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
