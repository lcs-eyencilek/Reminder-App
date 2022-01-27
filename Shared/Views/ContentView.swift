//
//  ContentView.swift
//  Shared
//
//  Created by Efe Yencilek on 2022-01-24.
//

import SwiftUI

struct ContentView: View {
    
    // To tell the screen to check for value change in this object
    @ObservedObject var store: TaskStore
    
    // Controls whether the add task is showing
    @State private var showingAddTask = false
    
    var body: some View {
        List(store.tasks) { task in
             TaskCell(task: task)
        }
        .navigationTitle("Reminders")
        // Trigger showingAddTask to make the pop-up view appear
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Add") {
                    showingAddTask = true
                }
            }
        }
        // Here's the pop-up view that'll appear depending on the value of showingAddTask
        .sheet(isPresented: $showingAddTask) {
            AddTask(store: store, showing: $showingAddTask)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView(store: testStore)
        }
    }
}
