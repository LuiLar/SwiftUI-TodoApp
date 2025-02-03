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
    var dueDate: Date
    var isCompleted: Bool
    
    init(index: Int, taskDesc: String, dueDate: Date, isCompleted: Bool) {
        self.orderIndex = index
        self.taskDesc = taskDesc
        self.dueDate = dueDate
        self.isCompleted = isCompleted
    }
    
    func updateTask() {
        self.isCompleted = !self.isCompleted
    }
    
    func getRemainingDays() -> Int {
        let from = Calendar.current.startOfDay(for: .now)
        let to = Calendar.current.startOfDay(for: self.dueDate)
        
        return Calendar.current.dateComponents([.day], from: from, to: to).day!
    }
}
