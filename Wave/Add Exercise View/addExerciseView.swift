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
    @IBOutlet weak var setsButton: UIButton!
    @IBOutlet weak var restButton: UIButton!
    @IBOutlet weak var amrapButton: UIButton!
    @IBOutlet var bottomStack: UIStackView!
    @IBOutlet weak var fullStack: UIStackView!
    
    var collectionScrollView: UIScrollView? = nil
    let generator = UIImpactFeedbackGenerator(style: .light)
    
    var selected: selectedButton = .sets
    var labelSelected: selectedLabel = .sets
    
    var lastContentOffset: CGPoint = CGPoint(x: 0, y: 0)
    
    var buttonArr: [UIButton] = []
    
    var intermediateBottomStack: UIStackView? = nil
    
    var viewModel: DesignWorkoutViewModel? = nil
    
    let largeAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: Colors.waveBlue, NSAttributedString.Key.font: UIFont(name: "Como-SemiBold", size: 40) as Any]
    let smallAttributes: [NSAttributedString.Key: Any]  = [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.4), NSAttributedString.Key.font: UIFont(name: "Como-Medium", size: 10) as Any]
    let largeUnselected: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.4), NSAttributedString.Key.font: UIFont(name: "Como-SemiBold", size: 40) as Any]
    let smallSelected: [NSAttributedString.Key: Any]  = [NSAttributedString.Key.foregroundColor: Colors.waveBlue, NSAttributedString.Key.font: UIFont(name: "Como-Medium", size: 10) as Any]
    
    var currentExercise: AddedExercise = AddedExercise()
    
    
    override func awakeFromNib() {
        setsLabel.numberOfLines = 0
        repsLabel.numberOfLines = 0
        weightLabel.numberOfLines = 0
        
        setSets()
        setReps()
        setWeight()
        
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
        
        buttonArr = [setsButton, restButton, amrapButton]
        intermediateBottomStack = bottomStack
        
        
        for label in [setsLabel, repsLabel, weightLabel] {
            label?.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapLabel))
            label?.addGestureRecognizer(tapGesture)
        }
        
        exerciseText.text = currentExercise.exercise
        
        
        
    }
    
    func setSets() {
        if labelSelected == .sets {
            setsLabel.attributedText = generateAttributedString("\(currentExercise.sets)", largeAttributes, "\nSETS", smallSelected)
        } else {
            setsLabel.attributedText = generateAttributedString("\(currentExercise.sets)", largeUnselected, "\nSETS", smallAttributes)
        }
    }
    
    func setReps() {
        if labelSelected == .reps {
            repsLabel.attributedText = generateAttributedString("\(currentExercise.reps)", largeAttributes, "\nREPS", smallSelected)
        } else {
            repsLabel.attributedText = generateAttributedString("\(currentExercise.reps)", largeUnselected, "\nREPS", smallAttributes)
        }
    }
    
    func setWeight() {
        if labelSelected == .weight {
            weightLabel.attributedText = generateAttributedString("\(currentExercise.weight)", largeAttributes, "\nLBS", smallAttributes)
        } else {
            weightLabel.attributedText = generateAttributedString("\(currentExercise.weight)", largeUnselected, "\nLBS", smallAttributes)
        }
    }
    
    @objc func tapLabel(_ sender: UITapGestureRecognizer) {
        if let label = sender.view as? UILabel {
            if label.tag == labelSelected.rawValue {
                return
            } else {
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
                
                let prevLabel = [setsLabel, repsLabel, weightLabel][labelSelected.rawValue]
                prevLabel?.textColor = UIColor.black.withAlphaComponent(0.4)
                
                let newLabel = [setsLabel, repsLabel, weightLabel][label.tag]
                newLabel?.textColor = Colors.waveBlue
                
                labelSelected = selectedLabel.caseFromRawValue(label.tag)
            }
        }
    }
    
    func setupToolbar() {
        let bar = UIToolbar()
        bar.barTintColor = .black
        
        let ximage = UIImage(systemName: "xmark")?.withTintColor(.white)
        let newBar = UIBarButtonItem(image: ximage, style: .plain, target: self, action: #selector(closeTapped))
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let weightUp = UIBarButtonItem(title: "+ 0.5 LBS", style: .plain, target: self, action: #selector(weightUpPressed))
        weightUp.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Como-Medium", size: 17) as Any], for: .normal)
        
        let checkImage = UIImage(systemName: "checkmark")?.withTintColor(.white)
        let done = UIBarButtonItem(image: checkImage, style: .plain, target: self, action: #selector(doneTapped))
        
        newBar.tintColor = .white
        done.tintColor = .white
        weightUp.tintColor = .white
        bar.items = [newBar, space, weightUp, space, done]
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
    
    @objc func weightUpPressed() {
        currentExercise.weight += 0.5
        setWeight()
    }
    
    @objc func closeTapped() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "close"), object: nil, userInfo: nil)
    }
    
    @objc func doneTapped() {
        if exerciseText.text != nil {
            currentExercise.exercise = exerciseText.text!
        }
        
        if viewModel!.exercises.keys.contains(currentExercise.id) {
            viewModel!.exercises[currentExercise.id] = currentExercise
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "close"), object: nil, userInfo: nil)
            return
        }
        viewModel!.exercises[currentExercise.id] = currentExercise
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "close"), object: nil, userInfo: nil)
    }

    @IBAction func bottomButtonTapped(_ sender: Any) {
        if let button = sender as? UIButton {
            switch button.tag {
            case 0:
                if selected.rawValue == 0 {
                    return
                } else {
                    switchButton(0)
                    switchToSets()
                }
            case 1:
                if selected.rawValue == 1 {
                    return
                } else {
                    switchButton(1)
                    switchToRest()
                }
            case 2:
                if selected.rawValue == 2 {
                    return
                } else {
                    switchButton(2)
                    switchToAmrap()
                }
            default:
                return
            }
        }
    }
    
    func switchButton(_ tag: Int) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        let prevSelected = buttonArr[selected.rawValue]
        prevSelected.setTitleColor(UIColor.black.withAlphaComponent(0.4), for: .normal)
        let currSelected = buttonArr[tag]
        currSelected.setTitleColor(Colors.waveBlue, for: .normal)
        
        if selected.rawValue == 1 {
            switchFromRest()
        }
        
        selected = selectedButton.caseFromRawValue(tag)
        
        switch tag {
        case 0:
            return
        case 1:
            return
        case 2:
            switchToAmrap()
        default:
            return
        }
    }
    
    func switchToRest() {
        let setsStr = currentExercise.getRestBetweenSetsString()
        let exercisesStr = currentExercise.getRestBetweenExercises()
        
        if labelSelected == .sets {
            setsLabel.attributedText = generateAttributedString(setsStr, largeAttributes, "\nBETWEEN SETS", smallSelected)
        } else {
            setsLabel.attributedText = generateAttributedString(setsStr, largeUnselected, "\nBETWEEN SETS", smallAttributes)
        }
        
        if labelSelected == .reps {
            repsLabel.attributedText = generateAttributedString(exercisesStr, largeAttributes, "\nBETWEEN EXERCISES", smallSelected)
        } else {
            repsLabel.attributedText = generateAttributedString(exercisesStr, largeUnselected, "\nBETWEEN EXERCISES", smallAttributes)
        }
        
        
        
        bottomStack.removeFromSuperview()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.layoutIfNeeded()
        })
    }
    
    func switchToAmrap() {
        setSets()
        setWeight()
        currentExercise.amrap = true
        if labelSelected.rawValue != 1 {
            repsLabel.attributedText = generateAttributedString("AMRAP", largeUnselected, "\nREPS", smallAttributes)
        } else {
            repsLabel.attributedText = generateAttributedString("AMRAP", largeAttributes, "\nREPS", smallSelected)
        }
    }
    
    func switchFromRest() {
        fullStack.addArrangedSubview(bottomStack)
        UIView.animate(withDuration: 0.3, animations: {
            self.layoutIfNeeded()
        })
    }
    
    func switchToSets() {
        exerciseText.text = currentExercise.exercise
        setSets()
        setReps()
        setWeight()
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

enum selectedButton: Int {
    case sets = 0
    case restTime = 1
    case amrap = 2
    
    static func caseFromRawValue(_ rawValue: Int) -> selectedButton {
        let choices = [selectedButton.sets, selectedButton.restTime, selectedButton.amrap]
        return choices[rawValue]
    }
}

enum selectedLabel : Int {
    case sets = 0
    case reps = 1
    case weight = 2
    
    static func caseFromRawValue(_ rawValue: Int) -> selectedLabel {
        let choices = [selectedLabel.sets, selectedLabel.reps, selectedLabel.weight]
        return choices[rawValue]
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
            let add = collectionScrollView!.contentOffset.x > lastContentOffset.x
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            if indexPath.row % 4 == 0 {
                switch selected {
                case .sets:
                    switch labelSelected {
                    case .sets:
                        if add {
                            currentExercise.sets += 1
                        } else {
                            if currentExercise.sets >= 2 {
                                currentExercise.sets -= 1
                            }
                        }
                        setSets()
                    case .reps:
                        if add {
                            currentExercise.reps += 1
                        } else {
                            if currentExercise.reps >= 2 {
                                currentExercise.reps -= 1
                            }
                        }
                        setReps()
                    case .weight:
                        if add {
                            currentExercise.weight += 1
                        } else {
                            if currentExercise.weight >= 2 {
                                currentExercise.weight -= 1
                            }
                        }
                        setWeight()
                    }
                case .amrap:
                    switch labelSelected {
                    case .sets:
                        if add {
                            currentExercise.sets += 1
                        } else {
                            if currentExercise.sets >= 2 {
                                currentExercise.sets -= 1
                            }
                        }
                        setSets()
                    case .reps:
                        return
                    case .weight:
                        if add {
                            currentExercise.weight += 1
                        } else {
                            if currentExercise.weight >= 2 {
                                currentExercise.weight -= 1
                            }
                        }
                        setWeight()
                    }
                case .restTime:
                    switch labelSelected {
                    case .sets:
                        if add {
                            currentExercise.restBetweenSets += 1
                        } else {
                            if currentExercise.restBetweenSets >= 2 {
                                currentExercise.restBetweenSets -= 1
                            }
                        }
                        switchToRest()
                    case .reps:
                        if add {
                            currentExercise.restBetweenExercises += 1
                        } else {
                            if currentExercise.restBetweenExercises >= 2 {
                                currentExercise.restBetweenExercises -= 1
                            }
                        }
                        switchToRest()
                    case .weight:
                        return
                    }
                }
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset
    }
    
    
}
