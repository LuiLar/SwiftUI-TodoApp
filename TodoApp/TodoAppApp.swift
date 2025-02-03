//
//  TodoAppApp.swift
//  TodoApp
//
//  Created by Luis on 30/01/2025.
//

import SwiftUI
import SwiftData

@main
struct TodoAppApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Task.self)
        }
    }
}
