//
//  EditCell.swift
//  Reminder App
//
//  Created by Efe Yencilek on 2022-01-28.
//

import SwiftUI

struct EditCell: View {
    
    // Task that'll be mutated
    @ObservedObject var task: Task
    
    // Binding value to control the view display
    @Binding var showing: Bool
    
    // Task values
    @State var description: String = ""
    @State var priority: TaskPriority = .low
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Description", text: $description)
                    
                    Picker("Priority", selection: $priority) {
                        Text(TaskPriority.low.rawValue).tag(TaskPriority.low)
                        Text(TaskPriority.medium.rawValue).tag(TaskPriority.medium)
                        Text(TaskPriority.high.rawValue).tag(TaskPriority.high)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    // This is how you change the picker style to segmented cells
                }
            }
            .navigationTitle("New Reminder")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        showing.toggle()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        saveTask()
                    }
                    .disabled(description.isEmpty)
                }
            }
            .task {
                description = task.description
                priority = task.priority
            }
        }
        .interactiveDismissDisabled()
    }
    
    func saveTask() {
        task.description =  description
        task.priority = priority
        
        showing.toggle()
    }
}

struct EditCell_Previews: PreviewProvider {
    static var previews: some View {
        EditCell(task: testData[0], showing: .constant(true))
    }
}
