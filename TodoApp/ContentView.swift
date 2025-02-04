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
    @State private var isInProgressExpanded: Bool = true
    @State private var isCompletedExpanded: Bool = true

    @Query(filter: #Predicate<Task> { task in
        task.isCompleted == false
    }, sort: \Task.orderIndex) var inProgressTasks: [Task]
    
    @Query(filter: #Predicate<Task> { task in
        task.isCompleted == true
    }, sort: \Task.orderIndex) var completedTasks: [Task]

    var body: some View {
        NavigationStack {
            List {
                if !inProgressTasks.isEmpty {
                    Section(
                        isExpanded: $isInProgressExpanded,
                        content: {
                            ForEach(inProgressTasks) { task in
                                TaskItemView(data: task, isEditMode: isEditMode == .active ? true : false)
                            }
                            .onMove { (indexSet, toIndex) in
                                for fromIndex in indexSet {
                                    inProgressTasks[fromIndex].orderIndex = toIndex - 1
                                    inProgressTasks[toIndex].orderIndex = fromIndex
                                }
                            }
                            .onDelete { indexSet in
                                for index in indexSet {
                                    context.delete(inProgressTasks[index])
                                }
                            }
                        },
                        header: { Text("In Progress") }
                    )
                }
                
                if !completedTasks.isEmpty {
                    Section(
                        isExpanded: $isCompletedExpanded,
                        content: {
                            ForEach(completedTasks) { task in
                                TaskItemView(data: task, isEditMode: isEditMode == .active ? true : false)
                            }
                            .onMove { (indexSet, toIndex) in
                                for fromIndex in indexSet {
                                    completedTasks[fromIndex].orderIndex = toIndex - 1
                                    completedTasks[toIndex].orderIndex = fromIndex
                                }
                            }
                            .onDelete { indexSet in
                                for index in indexSet {
                                    context.delete(completedTasks[index])
                                }
                            }
                        },
                        header: { Text("Completed") }
                    )
                }
            }
            .navigationTitle("Tasks")
            .listStyle(.sidebar)
            .sheet(isPresented: $isShowingNewTaskSheet) { NewTaskView(itemsCount: inProgressTasks.count) }
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    if !inProgressTasks.isEmpty { EditButton() }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    if !inProgressTasks.isEmpty {
                        Button("Add Task", systemImage: "plus") { isShowingNewTaskSheet.toggle() }
                    }
                }
            }
            .overlay {
                if inProgressTasks.isEmpty && completedTasks.isEmpty {
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
