//
//  GoalCardView.swift
//  MC1_Polar
//
//  Created by Ilia Sedelkin on 27/10/22.
//

import SwiftUI

struct GoalCardView: View {
    
    var currGoal: Goal
    
    var body: some View {
        if (currGoal.isPrimary == true) {
            PrimaryCardView(goal: currGoal)
        } else {
            SecondaryCardView(goal: currGoal)
        }
    }
    
    struct GoalCardView_Previews: PreviewProvider {
        static var previews: some View {
            let newGoal = Goal(title: "Test", description: "Test", taskList: taskData0, isPrimary: true)
            GoalCardView(currGoal: newGoal)
        }
    }
}
