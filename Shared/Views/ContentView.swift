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
    
    var body: some View {
        List(store.tasks) { task in
             TaskCell(task: task)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: testStore)
    }
}
