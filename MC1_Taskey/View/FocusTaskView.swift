//
//  FocusTaskView.swift
//  Taskey
//
//  Created by Ilia Sedelkin on 01/12/22.
//

import SwiftUI

struct FocusTaskView: View {
    
    var currentGoal: Goal
    var currentTask: Task?
    
    init(currentGoal: Goal) {
        self.currentGoal = currentGoal
        self.currentTask = findCurrentTask(currentGoal: currentGoal) ?? nil
    }
    
    var body: some View {
        Text(currentTask?.title ?? "Unknown task")
            .font(.largeTitle)
            .bold()
            .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
    }
}

func findCurrentTask(currentGoal: Goal) -> Task? {
    return currentGoal.taskList.first { $0.doneStatus == false }
    ?? nil
}

//struct TaskFocusView_Previews: PreviewProvider {
//    static var previews: some View {
//        FocusTaskView(currentTask: goalData[0].taskList[0])
//    }
//}
