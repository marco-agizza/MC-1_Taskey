//
//  Task.swift
//  MC1_Taskey
//  Polar
//
//  Created by Ilia Sedelkin on 21/10/22.
//

import Foundation

struct Task: Identifiable {
    
    let id = UUID()
    
    var title: String
    
    let creationTime: Date = Date()
    var doneStatus: Bool = false
    
    init(title: String) {
        self.title = title
    }
    
    mutating func editTitle(newTitle: String) {
        self.title = newTitle
    }
        
    mutating func changeStatus() {
        self.doneStatus.toggle()
    }
}
