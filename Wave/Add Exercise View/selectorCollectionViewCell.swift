//
//  selectorCollectionViewCell.swift
//  Wave
//
//  Created by Shyam Kumar on 1/29/21.
//

import UIKit

class selectorCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
    }
    
}
