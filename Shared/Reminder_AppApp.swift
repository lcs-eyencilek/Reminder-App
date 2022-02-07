//
//  Reminder_AppApp.swift
//  Shared
//
//  Created by Efe Yencilek on 2022-01-24.
//

import SwiftUI

@main
struct Reminder_AppApp: App {
    
    // Detect when app moves between the foreground, background, and inactive states
    @Environment(\.scenePhase) var scenePhase
    
    // Create the source of truth for our list of tasks (create the view model)
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
        .onChange(of: scenePhase) { newPhase in
            
            if newPhase == .inactive {
                
                print("Inactive")
                
            } else if newPhase == .active {
                
                print("Active")
                
            } else if newPhase == .background {
                
                print("Background")
                
                // Permanently save the list fo tasks
                store.persistTasks()
                
            }
            
        }
    }
}
