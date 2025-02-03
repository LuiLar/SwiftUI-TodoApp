//
//  ContentView.swift
//  TodoApp
//
//  Created by Luis on 30/01/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    
    @State private var isShowingNewTaskSheet = false
    @State private var currentTask: String = ""
    @State private var isEditMode: EditMode = .inactive

    @Query(sort: \Task.orderIndex) var tasks: [Task]

    var body: some View {
        NavigationStack {
            List {
                ForEach(tasks) { task in
                    TaskItemView(data: task, isEditMode: isEditMode == .active ? true : false)
                }
                .onMove { (indexSet, toIndex) in
                    for fromIndex in indexSet {
                        tasks[fromIndex].orderIndex = toIndex - 1
                        tasks[toIndex].orderIndex = fromIndex
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        context.delete(tasks[index])
                    }
                }
            }
            .navigationTitle("Tasks")
            .sheet(isPresented: $isShowingNewTaskSheet) { NewTaskView(itemsCount: tasks.count) }
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    if !tasks.isEmpty { EditButton() }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    if !tasks.isEmpty {
                        Button("Add Task", systemImage: "plus") { isShowingNewTaskSheet.toggle() }
                    }
                }
            }
            .overlay {
                if tasks.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No tasks", systemImage: "pencil.and.list.clipboard")
                    }, description: {
                        Text("Start adding tasks")
                    }, actions: {
                        Button("Add task") { isShowingNewTaskSheet.toggle() }
                    })
                }
            }
            .environment(\.editMode, $isEditMode)
        }
    }
}

#Preview { ContentView() }
