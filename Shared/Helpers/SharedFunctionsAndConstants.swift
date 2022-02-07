//
//  SharedFunctionsAndConstants.swift
//  Reminder App
//
//  Created by Efe Yencilek on 2022-02-06.
//

import Foundation

// Return the directory that we can save user data it
func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

// Define a file label (or file name) that we will write to within that directory
let savedTasksLabel = "savedTasks"
