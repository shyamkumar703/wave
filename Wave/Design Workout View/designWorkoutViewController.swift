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
    
    var viewModel = DesignWorkoutViewModel()
    var numElements = 0
    
    var viewsToDot: [UIView] = []
    
    var selectedExercise: AddedExercise? = nil
    
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
        closeTap.cancelsTouchesInView = false
        
        tableView.allowsSelection = true

        // Do any additional setup after loading the view.
    }
    
    @objc func resignName() {
        workoutName.resignFirstResponder()
    }
    
    @IBAction func addExercisePressed(_ sender: Any) {
        performSegue(withIdentifier: "addExercise", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        numElements = viewModel.exercises.count
        calculateTableViewHeight()
        selectedExercise = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        dotViews()
    }
    
    func dotViews() {
        for view in viewsToDot {
            drawDottedLine(start: CGPoint(x: view.bounds.minX, y: view.bounds.maxY), end: CGPoint(x: view.bounds.maxX, y: view.bounds.maxY), view: view)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? addWorkoutViewController {
            dest.viewModel = viewModel
            if selectedExercise != nil {
                dest.currExercise = selectedExercise
            }
        }
    }
    
    func calculateTableViewHeight() {
        if numElements == 0 {
            tableViewHeight.constant = 10
        } else {
            tableViewHeight.constant = CGFloat((numElements * 119))
        }
        view.layoutIfNeeded()
        dotViews()
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
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell") as? exerciseTableViewCell {
            cell.backgroundColor = .clear
            let ae = Array(viewModel.exercises.values)[indexPath.section]
            cell.setup(ae)
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        99
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        selectedExercise = Array(viewModel.exercises.values)[indexPath.section]
        performSegue(withIdentifier: "addExercise", sender: self)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == viewModel.exercises.count - 1 {
            let view = UIView()
            view.backgroundColor = .clear
            return view
        }
        
        let currExercise = Array(viewModel.exercises.values)[section]
        
        let view = UIView()

        let label = UILabel()
        label.text = currExercise.getRestBetweenExercises() + " REST"
        
        label.font = UIFont(name: "Como-Medium", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black.withAlphaComponent(0.4)
        
        view.addSubview(label)
        
        NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 5).isActive = true
        NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 75).isActive = true
        NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        let leftDottedView = UIView()
        leftDottedView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leftDottedView)
        
        NSLayoutConstraint(item: leftDottedView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 6).isActive = true
        NSLayoutConstraint(item: leftDottedView, attribute: .bottom, relatedBy: .equal, toItem: label, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: leftDottedView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint(item: leftDottedView, attribute: .right, relatedBy: .equal, toItem: label, attribute: .left, multiplier: 1, constant: 3).isActive = true
        
        let rightDottedView = UIView()
        rightDottedView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rightDottedView)
        
        NSLayoutConstraint(item: rightDottedView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: rightDottedView, attribute: .bottom, relatedBy: .equal, toItem: label, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: rightDottedView, attribute: .left, relatedBy: .equal, toItem: label, attribute: .right, multiplier: 1, constant: -3).isActive = true
        NSLayoutConstraint(item: rightDottedView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -8).isActive = true
        
        viewsToDot.append(leftDottedView)
        viewsToDot.append(rightDottedView)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.black.withAlphaComponent(0.4).cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3] // 7 is the length of dash, 3 is length of the gap.

        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }

}

