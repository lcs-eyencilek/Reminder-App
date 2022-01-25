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
            ContentView(store: store)
        }
    }
}
