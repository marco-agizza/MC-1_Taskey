//
//  Goal.swift
//  MC1_Polar
//
//  Created by Ilia Sedelkin on 20/10/22.
//

import Foundation

struct Goal : Identifiable {
    
    let id = UUID()
    
    var title: String
    var description: String
    
    var taskList: [Task]
    let creationTime: Date = Date()
    var doneStatus: Bool = false
    var isPrimary: Bool
    
    init(title: String, description: String = "", taskList: [Task] = [], isPrimary: Bool = false) {
        self.title = title
        self.description = description
        self.taskList = taskList
        self.isPrimary = isPrimary
    }
    
    mutating func editTitle(newTitle: String) {
        self.title = newTitle
    }
    
    mutating func addTask(taskTitle: String) {
        taskList.append(Task(title: taskTitle))
    }
    
    mutating func removeTask(index: Int) {
        taskList.remove(at: index)
    }
    
    mutating func changeStatus() {
        self.doneStatus.toggle()
    }
    
    mutating func lowerPriority() {
        self.isPrimary = false
    }
}
