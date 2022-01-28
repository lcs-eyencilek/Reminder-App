//
//  Task.swift
//  Reminder App
//
//  Created by Efe Yencilek on 2022-01-24.
//

import Foundation

class Task: Identifiable, ObservableObject {
    var id = UUID()
    
    // @Published lets you watch for changes on that value in a @StateObject
    @Published var description: String
    @Published var priority: TaskPriority
    @Published var completed: Bool
    
    internal init(id: UUID = UUID(), description: String, priority: TaskPriority, completed: Bool) {
        self.id = id
        self.description = description
        self.priority = priority
        self.completed = completed
    }
}

let testData = [
    Task(description: "Grow long hair", priority: .high, completed: true),
    Task(description: "Get modelling contract", priority: .medium, completed: false),
    Task(description: "Retire from teaching", priority: .low, completed: false)
]
