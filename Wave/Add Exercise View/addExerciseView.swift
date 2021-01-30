//
//  addExerciseView.swift
//  Wave
//
//  Created by Shyam Kumar on 1/30/21.
//

import UIKit

class addExercise: UIView {
    @IBOutlet weak var setsLabel: UILabel!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var exerciseText: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionScrollView: UIScrollView? = nil
    let generator = UIImpactFeedbackGenerator(style: .light)
    
    
    override func awakeFromNib() {
        let largeAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: Colors.waveBlue, NSAttributedString.Key.font: UIFont(name: "Como-SemiBold", size: 40) as Any]
        let smallAttributes: [NSAttributedString.Key: Any]  = [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.4), NSAttributedString.Key.font: UIFont(name: "Como-Medium", size: 10) as Any]
        let largeUnselected: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.4), NSAttributedString.Key.font: UIFont(name: "Como-SemiBold", size: 40) as Any]
        let smallSelected: [NSAttributedString.Key: Any]  = [NSAttributedString.Key.foregroundColor: Colors.waveBlue, NSAttributedString.Key.font: UIFont(name: "Como-Medium", size: 10) as Any]

        
        setsLabel.numberOfLines = 0
        repsLabel.numberOfLines = 0
        weightLabel.numberOfLines = 0
        
        setsLabel.attributedText = generateAttributedString("5", largeAttributes, "\nSETS", smallSelected)
        repsLabel.attributedText = generateAttributedString("5", largeUnselected, "\nREPS", smallAttributes)
        weightLabel.attributedText = generateAttributedString("135", largeUnselected, "\nLBS", smallAttributes)
        
        exerciseText.becomeFirstResponder()
        exerciseText.attributedPlaceholder = NSAttributedString(string: "Bench press",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.2)])
        
        
        setupToolbar()
        
        collectionView.register(UINib(nibName:"selectorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "select")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.isPagingEnabled = false
        collectionView.layoutIfNeeded()
        collectionView.scrollToItem(at: IndexPath(item: 5000, section: 0), at: .centeredHorizontally, animated: false)
        
        
    }
    
    func setupToolbar() {
        let bar = UIToolbar()
        bar.barTintColor = .black
        
        let ximage = UIImage(systemName: "xmark")?.withTintColor(.white)
        let newBar = UIBarButtonItem(image: ximage, style: .plain, target: self, action: #selector(closeTapped))
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let checkImage = UIImage(systemName: "checkmark")?.withTintColor(.white)
        let done = UIBarButtonItem(image: checkImage, style: .plain, target: self, action: #selector(doneTapped))
        
        newBar.tintColor = .white
        done.tintColor = .white
        bar.items = [newBar, space, done]
        bar.sizeToFit()
        exerciseText.inputAccessoryView = bar
    }
    
    func setScrollView() {
        for view in self.subviews {
            if view is UIScrollView {
                collectionScrollView = view as? UIScrollView
                break
            }
        }
    }
    
    @objc func closeTapped() {
        
    }
    
    @objc func doneTapped() {
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func generateAttributedString(_ string1: String, _ attributes1: [NSAttributedString.Key : Any], _ string2: String, _ attributes2: [NSAttributedString.Key : Any]) -> NSMutableAttributedString {
        let attString1 = NSMutableAttributedString(string: string1, attributes: attributes1)
        let attString2 = NSMutableAttributedString(string: string2, attributes: attributes2)
        attString1.append(attString2)
        return attString1
    }

}

extension addExercise: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "select", for: indexPath) as? selectorCollectionViewCell {
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionScrollView != nil {
            if indexPath.row % 4 == 0 {
                generator.impactOccurred()
            }
        }
    }
    
    
}
