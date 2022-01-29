//
//  AddTask.swift
//  Reminder App
//
//  Created by Efe Yencilek on 2022-01-25.
//

import SwiftUI

struct AddTask: View {
    
    // Get a reference to the store of tasks
    @ObservedObject var store: TaskStore
    
    // Details of the new task
    @State private var description = ""
    @State private var priority = TaskPriority.low
    
    // Whether to show this view (derived value)
    @Binding var showing: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Description", text: $description)
                    
                    Picker("Priority", selection: $priority) {
                        Text(TaskPriority.low.rawValue).tag(TaskPriority.low)
                        Text(TaskPriority.medium.rawValue).tag(TaskPriority.medium)
                        Text(TaskPriority.high.rawValue).tag(TaskPriority.high)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    // This is how you change the picker style to segmented cells
                }
            }
            .navigationTitle("New Reminder")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        showing.toggle()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        saveTask()
                    }
                    .disabled(description.isEmpty)
                }
            }
        }
        .interactiveDismissDisabled()
    }
    
    func saveTask() {
        print("Task value bound, updating...")
        // Initialize the new task
        let newTask = Task(description: description,
                           priority: priority,
                           completed: false)
        
        // Add the task to the store
        store.tasks.append(newTask)
        
        // Dismiss the view
        showing.toggle()
    }
}

struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        // This is a workaround to avoid binding a value in previews
        AddTask(store: testStore, showing: .constant(false))
    }
}
