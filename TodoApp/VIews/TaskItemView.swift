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
        let _ = print(self.isEditMode)

        HStack {
            Image(systemName: data.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(Color.accentColor)
                .frame(width: 30, alignment: .leading)
                .onTapGesture { data.updateTask() }
            
            if isEditMode == false {
                if data.isCompleted {
                    Text(data.taskDesc)
                        .foregroundStyle(.gray)
                        .strikethrough()
                } else {
                    Text(data.taskDesc)
                }
            } else {
                TextField("What to do?", text: $data.taskDesc)
            }

            Spacer()
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    let previewCompletedTask = Task(index: 0, taskDesc: "Preview this completed task", isCompleted: true)
    let previewNonCompletedTask = Task(index: 1, taskDesc: "Preview this non completed task", isCompleted: false)

    return List {
        TaskItemView(data: previewCompletedTask)
        TaskItemView(data: previewNonCompletedTask)
    }
}
