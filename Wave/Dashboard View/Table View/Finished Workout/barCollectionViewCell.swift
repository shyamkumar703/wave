//
//  barCollectionViewCell.swift
//  Wave
//
//  Created by Shyam Kumar on 1/26/21.
//

import UIKit

class barCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var barViewHeight: NSLayoutConstraint!
    
    func setup() {
        barView.layer.cornerRadius = 4
        barView.backgroundColor = Colors.waveBlue
    }
    
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = Colors.purple.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3] // 7 is the length of dash, 3 is length of the gap.

        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
    
    func animate() {
        barViewHeight.constant = 50
        UIView.animate(withDuration: 0.2, animations: {
            self.layoutIfNeeded()
        })
    }
    
}
