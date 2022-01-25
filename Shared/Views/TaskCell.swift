//
//  TaskCell.swift
//  Reminder App
//
//  Created by Efe Yencilek on 2022-01-25.
//

import SwiftUI

struct TaskCell: View {
    
    // To tell the screen to check for value change in this object
    @ObservedObject var task: Task
    
    var body: some View {
        HStack {
            Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                .onTapGesture {

                    task.completed.toggle()
                    
                }
            Text(task.description)
        }
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(task: testData[0])
        //TaskCell(task: testData[1])
    }
}
