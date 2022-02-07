//
//  ImportantTasks.swift
//  Reminder App
//
//  Created by Efe Yencilek on 2022-01-28.
//

import SwiftUI

struct ImportantTasks: View {
    
    // To tell the screen to check for value change in this object
    @ObservedObject var store: TaskStore
    
    // Controls whether the add task is showing
    @State private var showingAddTask = false
    
    // Whether to show completed tasks or not
    @State var showingCompletedTasks = true
    
    // Controls the update status of the ContentView
    // listShouldUpdate has to be used somewhere in the body paragraph so that SwiftUI checks this variable to update teh scene
    @State var listShouldUpdate = false
    
    var body: some View {
        
        // We have this decleration mainly to invoke the screen to refresh
        let _ = print("listShouldUpdate has been toggled. Current value is: \(listShouldUpdate)")
        
        List {
            ForEach(store.tasks) { task in
                // Dismisses the current task if showImportant is true and the task priority is not equal to high
                if !showingCompletedTasks {
                    if !task.completed && task.priority == .high {
                        TaskCell(task: task, triggerListUpdate: $listShouldUpdate)
                    }
                } else if task.priority == .high  {
                    TaskCell(task: task, triggerListUpdate: $listShouldUpdate)
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
            
            #if os(iOS)
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            #endif
            
            #if os(iOS)
            ToolbarItem(placement: .bottomBar) {
                Button(" \(showingCompletedTasks ? "Hide" : "Show") Completed") {
                    showingCompletedTasks.toggle()
                }
            }
            #else
            ToolbarItem(placement: .automatic) {
                Button(" \(showingCompletedTasks ? "Hide" : "Show") Completed") {
                    showingCompletedTasks.toggle()
                }
            }
            #endif
        }
        // Here's the pop-up view that'll appear depending on the value of showingAddTask
        .sheet(isPresented: $showingAddTask) {
            AddTask(store: store, showing: $showingAddTask)
        }
    }
}

struct ImportantTasks_Previews: PreviewProvider {
    static var previews: some View {
        ImportantTasks(store: testStore)
    }
}
