//
//  ContentView.swift
//  Shared
//
//  Created by Efe Yencilek on 2022-01-24.
//

import SwiftUI

struct ContentView: View {
    
    let showImportant: Bool
    
    // To tell the screen to check for value change in this object
    @ObservedObject var store: TaskStore
    
    // Controls whether the add task is showing
    @State private var showingAddTask = false
    
    // Whether to show completed tasks or not
    @State var showingCompletedTasks = true
    
    // Controls the update status of the ContentView
    // listShouldUpdate has to be used somewhere in the body paragraph so that SwiftUI checks this variable to update teh scene
    @State var listShouldUpdate = false
    
    @State var selectedTask: Task? = nil
    
    var body: some View {
        
        // We have this decleration mainly to invoke the screen to refresh
        let _ = print("listShouldUpdate has been toggled. Current value is: \(listShouldUpdate)")
        
        List {
            ForEach(store.tasks) { task in
                // Dismisses the current task if showImportant is true and the task priority is not equal to high
                if (!showImportant || task.priority == .high) {
                    if !showingCompletedTasks {
                        if !task.completed {
                            TaskCell(task: task, mutatingTask: $selectedTask, triggerAddTask: $showingAddTask, triggerListUpdate: $listShouldUpdate)
                        }
                    } else {
                        TaskCell(task: task, mutatingTask: $selectedTask, triggerAddTask: $showingAddTask, triggerListUpdate: $listShouldUpdate)
                    }
                }
            }
            .onDelete(perform: store.deleteItems)
            .onMove(perform: store.moveItems)
            // You don't call the function, you just invoke it so no ()
        }
        .navigationTitle("Reminders")
        // Trigger showingAddTask to make the pop-up view appear
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Add") {
                    showingAddTask.toggle()
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            
            ToolbarItem(placement: .bottomBar) {
                Button(" \(showingCompletedTasks ? "Hide" : "Show") Completed") {
                    showingCompletedTasks.toggle()
                }
            }
        }
        // Here's the pop-up view that'll appear depending on the value of showingAddTask
        .sheet(isPresented: $showingAddTask) {
            AddTask(mutatingTask: $selectedTask, store: store, showing: $showingAddTask)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView(showImportant: false, store: testStore)
        }
    }
}
