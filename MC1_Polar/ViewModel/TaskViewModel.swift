//
//  TaskViewmodel.swift
//  MC1_Polar
//
//  Created by Marco Agizza on 25/10/22.
//

import Foundation

// whe are saying that this class is seen by everyone in the project
class TaskViewModel: ObservableObject {
    @Published var tasks : [Task] = []
    
    init(currGoal: Goal) {
        tasks = currGoal.taskList
    }
    
    init() {}
    
    func addTask(newTaskTitle: String) {
        tasks.append(Task(title: newTaskTitle))
    }
    
    func remove(position: IndexSet) {
        tasks.remove(atOffsets: position)
    }
    
}
