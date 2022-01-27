//
//  TaskStore.swift
//  Reminder App
//
//  Created by Efe Yencilek on 2022-01-24.
//

import Foundation

class TaskStore: ObservableObject {
    
    //MARK: Stored properties
    @Published var tasks: [Task]
    
    //MARK: Initializers
    init(tasks: [Task] = []) {
        self.tasks = tasks
    }
    
    //MARK: Functions
    func deleteItems(at offsets: IndexSet) {
        // "offsets" contains a set of items selected for deletion.
        // The set is then passed to the build-in "remove" method on
        // the "tasks array which handles removel from the array".
        tasks.remove(atOffsets: offsets)
    }
}

let testStore = TaskStore(tasks: testData)
