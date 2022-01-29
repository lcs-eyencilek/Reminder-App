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
    
    // Bind listShouldUpdate from ContentView
    @Binding var triggerListUpdate: Bool
    // Computed property for task color
    var taskColor: Color {
        switch task.priority {
        case .high:
            return Color.red
        case .medium:
            return Color.blue
        case .low:
            return Color.primary
            // We use primary to change the color automatically depending on the background color (always a color that stands out)
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                .onTapGesture {

                    task.completed.toggle()
                    
                    withAnimation {
                        triggerListUpdate.toggle()
                    }
                }
            Text(task.description)
            .font(.caption)
        }
        .foregroundColor(self.taskColor)
    }
}

/*
struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(task: testData[0], triggerListUpdate: Binding.constant(true))
        //TaskCell(task: testData[1])
    }
}
 */
