//
//  addWorkoutViewController.swift
//  Wave
//
//  Created by Shyam Kumar on 1/29/21.
//

import UIKit

class addWorkoutViewController: UIViewController {
    @IBOutlet weak var viewToBottom: NSLayoutConstraint!
    @IBOutlet weak var addView: UIView!
    let addNib = UINib(nibName: "addExerciseView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! addExercise
    
    let screenKeyboardDict = [667: 280, 736: 291, 896: 366, 812: 356, 844: 356, 926: 366, 568: 280]
    
    var viewModel: DesignWorkoutViewModel? = nil
    
    var currExercise: AddedExercise? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenHeight = UIScreen.main.bounds.height
        viewToBottom.constant = CGFloat(screenKeyboardDict[Int(screenHeight)]! + 25)
        view.layoutIfNeeded()
        
        
        addNib.addViewToSuperview(addView)
        addNib.viewModel = viewModel
        addNib.currentExercise = currExercise ?? AddedExercise()
        addNib.switchToSets()
        
        NotificationCenter.default.addObserver(self, selector: #selector(closeTapped), name: NSNotification.Name("close"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func closeTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        addNib.setScrollView()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
