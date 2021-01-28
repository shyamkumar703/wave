//
//  finWorkoutTableViewCell.swift
//  Wave
//
//  Created by Shyam Kumar on 1/26/21.
//

import UIKit

class finWorkoutTableViewCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var muscleGroup1: UILabel!
    @IBOutlet weak var muscleGroup2: UILabel!
    @IBOutlet weak var muscleGroup3: UILabel!
    @IBOutlet weak var barCollectionView: UICollectionView!
    @IBOutlet weak var dashedLineView: UIView!
    
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
        
        configureMuscleGroups()
        
        barCollectionView.delegate = self
        barCollectionView.dataSource = self
        
        drawDottedLine(start: CGPoint(x: dashedLineView.bounds.minX, y: dashedLineView.bounds.maxY), end: CGPoint(x: dashedLineView.bounds.maxX, y: dashedLineView.bounds.maxY), view: dashedLineView)
    }
    
    func configureMuscleGroups() {
        let labels = [muscleGroup1, muscleGroup2, muscleGroup3]
        for label in labels {
            label?.layer.masksToBounds = true
            label?.layer.cornerRadius = 5
            label?.backgroundColor = Colors.purple.withAlphaComponent(0.15)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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

}

extension finWorkoutTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let labelArr = ["CHE", "SHO", "TRI"]
        if let cell = barCollectionView.dequeueReusableCell(withReuseIdentifier: "barCell", for: indexPath) as? barCollectionViewCell {
            cell.setup()
            if indexPath.row == 0 {
                cell.barViewHeight.constant = 30
                cell.barView.backgroundColor = Colors.orange
            } else {
                cell.barViewHeight.constant = 50
                cell.barView.backgroundColor = Colors.green
            }
            cell.label.text = labelArr[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
