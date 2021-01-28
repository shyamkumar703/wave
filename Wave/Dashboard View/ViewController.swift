//
//  ViewController.swift
//  Wave
//
//  Created by Shyam Kumar on 1/25/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var workoutButton: UIButton!
    @IBOutlet weak var dashboardButton: UIButton!
    @IBOutlet weak var progressButton: UIButton!
    @IBOutlet weak var scoreboardView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scoreboardViewHeight: NSLayoutConstraint!
    
    var expandedIndices: [IndexPath] = []
    
    var tableViewSrc: [TVCell] = []
    
    var dashboardVM: DashboardViewModel = DashboardViewModel()
    
    var selected: SelectedButton = .dashboard {
        didSet {
            switch selected {
            case .dashboard:
                selectedButton = dashboardButton
            case .workouts:
                selectedButton = workoutButton
            case .progress:
                selectedButton = progressButton
            }
        }
    }
    
    var selectedButton: UIButton? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dashboardButton.setTitleColor(Colors.waveBlue, for: .normal)
        dashboardButton.backgroundColor = .white
        dashboardButton.layer.cornerRadius = 15
        
        scoreboardView.layer.cornerRadius = 5
        scoreboardView.layer.shadowColor = UIColor.black.cgColor
        scoreboardView.layer.shadowOpacity = 0.5
        scoreboardView.layer.shadowOffset = .zero
        scoreboardView.layer.shadowRadius = 2
        
        tableView.register(UINib(nibName:"progressCell", bundle: nil), forCellReuseIdentifier: "progressCell")
        
        tableViewSrc = dashboardVM.getDashboardCells(tableView, selected)
        
        let scoreboard: Scoreboard = getScoreboardView()
        scoreboardViewHeight.constant = scoreboard.height
        scoreboard.view.addViewToSuperview(scoreboardView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableViewHeight.constant = 650
        
        for button in [dashboardButton, progressButton, workoutButton] {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
            button?.addGestureRecognizer(tapGesture)
            button?.layer.cornerRadius = 15
        }
        
        selectedButton = dashboardButton
    }
    
    func getScoreboardView() -> Scoreboard {
        switch selected {
        case .dashboard:
            let thisWeek = (Bundle.main.loadNibNamed("thisWeek", owner: self, options: nil)![0]) as! thisWeek
            thisWeek.setup()
            return Scoreboard(157, thisWeek)
        case .progress:
            let totalWorkouts = (Bundle.main.loadNibNamed("totalWorkouts", owner: self, options: nil)![0]) as! totalWorkouts
            return Scoreboard(157, totalWorkouts)
        case .workouts:
            let lastWorkout = (Bundle.main.loadNibNamed("finWorkoutNib", owner: self, options: nil)![0]) as! finWorkoutNib
            return Scoreboard(250, lastWorkout)
        }
    }
    
    @objc func buttonTapped(_ sender: UITapGestureRecognizer) {
        if let tapped = sender.view {
            if tapped.tag == selected.rawValue {
                return
            } else {
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
                let newButton = SelectedButton.buttonForValue(tapped.tag)
                switchViewTransition(newButton)
            }
        }
    }
    
    func switchViewTransition(_ newButton: SelectedButton) {
        if let previousButton = selectedButton {
            selected = newButton
            
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                previousButton.backgroundColor = .clear
                previousButton.setTitleColor(.white, for: .normal)
                self.selectedButton?.backgroundColor = .white
                self.selectedButton?.setTitleColor(Colors.waveBlue, for: .normal)
            }, completion: {fin in
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
                    self.tableView.alpha = 0
                    self.scoreboardView.alpha = 0
                }, completion: { fin in
                    for subview in self.scoreboardView.subviews {
                        subview.removeFromSuperview()
                    }
                    
                    let newScoreboard = self.getScoreboardView()
                    self.scoreboardViewHeight.constant = newScoreboard.height
                    self.view.layoutIfNeeded()
                    newScoreboard.view.addViewToSuperview(self.scoreboardView)
                    
                    self.tableViewSrc = self.dashboardVM.getDashboardCells(self.tableView, self.selected)
                    self.tableView.reloadData()
                    
                    UIView.animate(withDuration: 0.2, delay: 0.25, options: .curveLinear, animations: {
                        self.scoreboardView.alpha = 1
                        self.tableView.alpha = 1
                    }, completion: nil)
                    
                })
            })
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewSrc.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewSrc[indexPath.row].cell ?? UITableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewSrc[indexPath.row].height
    }
    
    
}

extension UIView {
    func addViewToSuperview(_ superview: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: superview, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: superview, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
    }
    
    func addExpandingViewToSuperview(_ superview: UIView, _ bottomConstraint: CGFloat, _ height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: superview, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: superview, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 1, constant: bottomConstraint).isActive = true
        NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height).isActive = true
    }
}

