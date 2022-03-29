//
//  DetailView.swift
//  HabitTracker
//
//  Created by harsh Khandelwal on 23/10/21.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var activities : Activities
    
    @State private var completedTimes = 0
    var activity : Activity
    var body: some View {
        Form {
            Section(header : Text("Description of Acivity")){
                Text("\(self.activity.description)")
            }
            Section(header : Text("Number of times completed")){
                Stepper(value: $completedTimes, in : 0...Int.max, step: 1){
                    Text("Completed times : \(completedTimes) times")
                }
            }
        }
        .navigationTitle(Text("\(self.activity.name)"))
        .navigationBarItems(trailing:
            Button(action: {
                    self.saveActivity()
                },
                label: {
                    Text("Save")
                }
            )
        )
        .onAppear{
            self.completedTimes = self.activity.completedItems
        }
    }
    
    func saveActivity(){
        if let indexItem = self.activities.items.firstIndex(where: { (item) -> Bool in
            item == self.activity
        }) {
                let tempActivity = Activity(name: self.activity.name, description: self.activity.description, completedItems: self.completedTimes)
                self.activities.items.remove(at: indexItem)
                self.activities.items.insert(tempActivity, at: indexItem)
            
                self.activities.saveActivities()
            }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(activities: Activities(), activity: Activity(name: "name", description: "description", completedItems: 0))
    }
}
