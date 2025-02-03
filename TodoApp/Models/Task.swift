//
//  Task.swift
//  TodoApp
//
//  Created by Luis on 31/01/2025.
//

import Foundation
import SwiftData

@Model
class Task: Identifiable {
    var orderIndex: Int
    var taskDesc: String
    var isCompleted: Bool
    
    init(index: Int, taskDesc: String, isCompleted: Bool) {
        self.orderIndex = index
        self.taskDesc = taskDesc
        self.isCompleted = isCompleted
    }
    
    func updateTask() {
        self.isCompleted = !self.isCompleted
    }
}
