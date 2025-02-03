//
//  NewTaskView.swift
//  TodoApp
//
//  Created by Luis on 31/01/2025.
//

import SwiftUI

struct NewTaskView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss

    @State private var description = ""
    @State private var dueDate = Date()
    @State private var isCompleted = false
    
    var itemsCount: Int

    var body: some View {
        NavigationStack {
            Form {
                TextField("What to do?", text: $description)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: [.date])
            }
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        let newTask = Task(index: itemsCount, taskDesc: description, dueDate: dueDate, isCompleted: isCompleted)
                        context.insert(newTask)
                        dismiss()
                    }
                    .disabled(description.count < 3)
                }
            }
        }
    }
}

#Preview { NewTaskView(itemsCount: 0) }
