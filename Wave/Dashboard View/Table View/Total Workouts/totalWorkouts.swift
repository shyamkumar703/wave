//
//  totalWorkouts.swift
//  Wave
//
//  Created by Shyam Kumar on 1/26/21.
//

import UIKit

class totalWorkouts: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    var animate = false
    
    override func awakeFromNib() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName:"totalWorkoutCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "barCell")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension totalWorkouts: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "barCell", for: indexPath) as? totalWorkoutCollectionViewCell {
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
