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
    
    // Whether to show completed tasks or not
    @State var showingCompletedTasks = true
    
    // What priority of tasks to show
    @State private var selectedPriorityForVisibleTasks: VisibleTaskPriority = .all
    
    // Controls the update status of the ContentView
    // listShouldUpdate has to be used somewhere in the body paragraph so that SwiftUI checks this variable to update teh scene
    @State var listShouldUpdate = false
    
    var body: some View {
        
        // We have this decleration mainly to invoke the screen to refresh
        let _ = print("listShouldUpdate has been toggled. Current value is: \(listShouldUpdate)")
        VStack {
            // label for picker
            Text("Filter by...")
                .font(Font.caption.smallCaps())
                .foregroundColor(.secondary)
            
            Picker("Priority", selection: $selectedPriorityForVisibleTasks) {
                Text(VisibleTaskPriority.all.rawValue).tag(VisibleTaskPriority.all)
                Text(VisibleTaskPriority.low.rawValue).tag(VisibleTaskPriority.low)
                Text(VisibleTaskPriority.medium.rawValue).tag(VisibleTaskPriority.medium)
                Text(VisibleTaskPriority.high.rawValue).tag(VisibleTaskPriority.high)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            List {
                ForEach(store.tasks) { task in
                    // Dismisses the current task if showImportant is true and the task priority is not equal to high
                    if !showingCompletedTasks {
                        if !task.completed {
                            if selectedPriorityForVisibleTasks == .all {
                                TaskCell(task: task, triggerListUpdate: $listShouldUpdate)
                            } else if selectedPriorityForVisibleTasks.rawValue == task.priority.rawValue {
                                TaskCell(task: task, triggerListUpdate: $listShouldUpdate)
                            }
                        }
                    } else {
                        if selectedPriorityForVisibleTasks == .all {
                            TaskCell(task: task, triggerListUpdate: $listShouldUpdate)
                        } else if selectedPriorityForVisibleTasks.rawValue == task.priority.rawValue {
                            TaskCell(task: task, triggerListUpdate: $listShouldUpdate)
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
                
                ToolbarItem(placement: .bottomBar) {
                    Button(" \(showingCompletedTasks ? "Hide" : "Show") Completed") {
                        showingCompletedTasks.toggle()
                    }
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
