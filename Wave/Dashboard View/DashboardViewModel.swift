//
//  DashboardViewModel.swift
//  Wave
//
//  Created by Shyam Kumar on 1/27/21.
//

import Foundation
import UIKit

class DashboardViewModel {
    
    func getDashboardCells(_ tableView: UITableView, _ selectedButton: SelectedButton) -> [TVCell] {
        switch selectedButton {
        case .dashboard:
            let yesterday = TVCell(114, "prevWorkout", tableView)
            let today = TVCell(114, "prevWorkout", tableView)
            return [today, yesterday]
        case .progress:
            let bp = TVCell(150, "progressCell", tableView)
            let squat = TVCell(150, "progressCell", tableView)
            return [bp, squat]
        case .workouts:
            let today = TVCell(114, "prevWorkout", tableView)
            let yesterday = TVCell(250, "finWorkout", tableView)
            let dayBefore = TVCell(250, "finWorkout", tableView)
            return [today, yesterday, dayBefore]
        }
    }
}

public struct Scoreboard {
    var height: CGFloat
    var view: UIView
    
    init(_ height: CGFloat, _ view: UIView) {
        self.height = height
        self.view = view
    }
}

public struct TVCell {
    var height: CGFloat
    var identifier: String
    var cell: UITableViewCell? = nil
    
    init(_ height: CGFloat, _ identifier: String, _ tableView: UITableView) {
        self.height = height
        self.identifier = identifier
        
        switch identifier {
        case "prevWorkout":
            if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? prevWorkoutTableViewCell {
                self.cell = cell
            }
        case "finWorkout":
            if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? finWorkoutTableViewCell {
                self.cell = cell
            }
        case "progressCell":
            if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? progressCell {
                cell.backgroundColor = .clear
                self.cell = cell
            }
        default:
            return
        }
        
    }
}

public enum SelectedButton: Int {
    case dashboard = 1
    case progress = 2
    case workouts = 0
    
    static func buttonForValue(_ rawValue: Int) -> SelectedButton {
        switch rawValue {
        case 0:
            return .workouts
        case 1:
            return .dashboard
        case 2:
            return .progress
        default:
            return .dashboard
        }
    }
}
