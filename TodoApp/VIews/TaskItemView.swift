//
//  TaskItemView.swift
//  TodoApp
//
//  Created by Luis on 31/01/2025.
//

import SwiftUI

struct TaskItemView: View {
    @Bindable var data: Task
    var isEditMode: Bool?

    var body: some View {
        HStack {
            Image(systemName: data.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(Color.accentColor)
                .frame(width: 30, alignment: .leading)
                .onTapGesture { data.updateTask() }
            
            if isEditMode == true {
                TextField("What to do?", text: $data.taskDesc)
            } else {
                if data.isCompleted {
                    Text(data.taskDesc)
                        .foregroundStyle(.gray)
                        .strikethrough()
                } else {
                    Text(data.taskDesc)
                }
            }
            
            Spacer()

            if isEditMode == true {
                DatePicker("", selection: $data.dueDate, displayedComponents: [.date])
            } else {
                Text("\(data.getRemainingDays()) days to go")
                    .font(.footnote)
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    let previewCompletedTask = Task(index: 0, taskDesc: "Preview this completed task", dueDate: .now, isCompleted: true)
    let previewNonCompletedTask = Task(index: 1, taskDesc: "Preview this non completed task", dueDate: .now, isCompleted: false)

    return List {
        TaskItemView(data: previewCompletedTask)
        TaskItemView(data: previewNonCompletedTask)
    }
}
