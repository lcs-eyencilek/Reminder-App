//
//  Reminder_AppApp.swift
//  Shared
//
//  Created by Efe Yencilek on 2022-01-24.
//

import SwiftUI

@main
struct Reminder_AppApp: App {
    
    @StateObject private var store = TaskStore(tasks: testData)
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    ContentView(store: store)
                }.tabItem {
                    Image(systemName: "list.fill")
                    Text("All")
                }
                
                NavigationView {
                    ImportantTasks(store: store)
                }.tabItem {
                    Image(systemName: "list.fill")
                    Text("Important")
                }
            }
        }
    }
}
