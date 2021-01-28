//
//  totalWorkoutCollectionViewCell.swift
//  Wave
//
//  Created by Shyam Kumar on 1/26/21.
//

import UIKit

class totalWorkoutCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var barLabel: UILabel!
    @IBOutlet weak var barViewHeight: NSLayoutConstraint!
    var maxHeight = 70
    
    override func awakeFromNib() {
        barView.layer.cornerRadius = 5
//        barView.backgroundColor = Colors.waveBlue
        
        let randomHeight = Int.random(in: (maxHeight - 20)...maxHeight)
        let randomColor = Int.random(in: 0...3)
        
        let possibleColors = [Colors.waveBlue, Colors.purple, Colors.green, Colors.orange]
        
        barViewHeight.constant = CGFloat(randomHeight)
        barView.backgroundColor = possibleColors[randomColor]
    }
    
}
