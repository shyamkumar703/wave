//
//  designWorkoutViewController.swift
//  Wave
//
//  Created by Shyam Kumar on 1/29/21.
//

import UIKit
import Floaty

class designWorkoutViewController: UIViewController {
    @IBOutlet weak var workoutName: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var addExerciseButton: UIButton!
    
    var numElements: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName:"exerciseTableViewCell", bundle: nil), forCellReuseIdentifier: "exerciseCell")
        calculateTableViewHeight()
        
        addExerciseButton.layer.cornerRadius = 5
        addExerciseButton.layer.borderWidth = 1
        addExerciseButton.layer.borderColor = Colors.waveBlue.cgColor
        
        workoutName.becomeFirstResponder()
        workoutName.textColor = .black
        workoutName.attributedPlaceholder = NSAttributedString(string: "Workout name",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.2)])
        
        let closeTap = UITapGestureRecognizer(target: self, action: #selector(resignName))
        view.addGestureRecognizer(closeTap)

        // Do any additional setup after loading the view.
    }
    
    @objc func resignName() {
        workoutName.resignFirstResponder()
    }
    
    @IBAction func addExercisePressed(_ sender: Any) {
        performSegue(withIdentifier: "addExercise", sender: self)
    }
    
    func calculateTableViewHeight() {
        if numElements == 0 {
            tableViewHeight.constant = 10
        } else {
            tableViewHeight.constant = CGFloat((numElements * 99) + ((numElements - 1) * 10))
        }
        view.layoutIfNeeded()
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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

extension designWorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numElements
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell") as? exerciseTableViewCell {
            cell.backgroundColor = .clear
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        99
    }
}

