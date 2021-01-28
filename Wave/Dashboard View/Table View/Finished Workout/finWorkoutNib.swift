//
//  finWorkoutNib.swift
//  Wave
//
//  Created by Shyam Kumar on 1/27/21.
//

import UIKit

class finWorkoutNib: UIView {
    @IBOutlet weak var workoutGroup1: UILabel!
    @IBOutlet weak var workoutGroup2: UILabel!
    @IBOutlet weak var workoutGroup3: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dashView: UIView!
    
    override func awakeFromNib() {
        collectionView.register(UINib(nibName:"totalWorkoutCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "barCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        layer.cornerRadius = 5
        
        let labels = [workoutGroup1, workoutGroup2, workoutGroup3]
        for label in labels {
            label?.layer.masksToBounds = true
            label?.layer.cornerRadius = 5
            label?.backgroundColor = Colors.purple.withAlphaComponent(0.15)
        }
        
        drawDottedLine(start: CGPoint(x: dashView.bounds.minX, y: dashView.bounds.maxY), end: CGPoint(x: dashView.bounds.maxX, y: dashView.bounds.maxY), view: dashView)
        
        clipsToBounds = true
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
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

}

extension finWorkoutNib: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let barLabels = ["CHE", "SHO", "TRI"]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "barCell", for: indexPath) as? totalWorkoutCollectionViewCell {
            cell.barLabel.text = barLabels[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
