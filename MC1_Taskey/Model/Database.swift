//
//  Database.swift
//  MC1_Taskey
//  Polar
//
//  Created by Marco Agizza on 24/10/22.
//

import Foundation

let taskData0 = [
    Task(title: "Create an appropriate CV"),
    Task(title: "Look for some agencies that you like"),
    Task(title: "Answer to all the interview requests")
]

let taskData1 = [
    Task(title: "Do excercise")
]

let taskData2 = [
    Task(title: "Task 1"),
    Task(title: "Task 2"),
    Task(title: "Task 3")
]

var goalData = [
    Goal(title: "Looking for a new job", description: "You know, I need money", taskList: taskData0, isPrimary: true),
    Goal(title: "Learn English", description: "To speak", isPrimary: false),
    Goal(title: "Get in shape", description: "", taskList: taskData1, isPrimary: false),
    Goal(title: "Become more confident", description: "Description sample", taskList: taskData2, isPrimary: false)
]
