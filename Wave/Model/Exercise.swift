//
//  Exercise.swift
//  Wave
//
//  Created by Shyam Kumar on 1/31/21.
//

import Foundation

class AddedExercise {
    var id: String
    var exercise: String
    var sets: Int
    var reps: Int
    var weight: Double
    var amrap: Bool
    var restBetweenSets: Int
    var restBetweenExercises: Int
    
    init() {
        exercise = ""
        sets = 5
        reps = 5
        weight = 135
        amrap = false
        restBetweenSets = 150
        restBetweenExercises = 180
        id = UUID().uuidString
    }
    
    func getRestBetweenSetsString() -> String {
        let mins = restBetweenSets / 60
        let secs = restBetweenSets % 60
        if secs < 10 {
            return "\(mins):0\(secs)"
        } else {
            return "\(mins):\(secs)"
        }
    }
    
    func getRestBetweenExercises() -> String {
        let mins = restBetweenExercises / 60
        let secs = restBetweenExercises % 60
        if secs < 10 {
            return "\(mins):0\(secs)"
        } else {
            return "\(mins):\(secs)"
        }
    }
}
