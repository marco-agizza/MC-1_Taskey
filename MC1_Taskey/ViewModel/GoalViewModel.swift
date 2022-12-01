//
//  GoalViewModel.swift
//  MC1_Taskey
//  Polar
//
//  Created by Marco Agizza on 25/10/22.
//

import Foundation

// we are saying that this class is seen by everyone in the project
class GoalViewModel: ObservableObject {
    @Published var goals : [Goal] = []
    @Published var selectedGoal : Int = 0
    
    init() {
        goals = goalData
    }
    
    func addGoal(newGoal: Goal) {
        goals.append(newGoal)
    }
    
    // TODO Current implementation may violate the single responsibility principle
    func remove(position: IndexSet) {
        goals.remove(atOffsets: position)
        
        goals[0].isPrimary = true
        for index in goals[1...].indices {
            goals[index].lowerPriority()
        }
    }
}
