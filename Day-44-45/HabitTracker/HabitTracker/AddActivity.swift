//
//  AddActivity.swift
//  HabitTracker
//
//  Created by harsh Khandelwal on 23/10/21.
//

import SwiftUI

struct AddActivity: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var activities : Activities
    
    @State private var name = ""
    @State private var description = ""
    @State private var amount = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header : Text("Name of Habit")){
                    TextField("Name" , text: $name)
                }
                Section(header : Text("Description of Acivity")){
                    TextField("Description" , text: $description)
                }
                Section(header : Text("Number of times completed")){
                    Stepper(value: $amount, in : 0...Int.max, step: 1){
                        Text("\(amount) times")
                    }
                }
            }
            .navigationTitle("Add new Activity")
            .navigationBarItems(trailing:
                Button(action: {
                let item = Activity(name: self.name, description: self.description, completedItems: self.amount)
                        self.activities.items.append(item)
                
                        self.activities.saveActivities()
                
                        self.presentationMode.wrappedValue.dismiss()
                    },
                    label: {
                        Text("Save")
                    }
                )
            )
        }
    }
}
struct AddActivity_Previews: PreviewProvider {
    static var previews: some View {
        AddActivity( activities: Activities())
    }
}
