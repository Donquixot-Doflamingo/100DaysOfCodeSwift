//
//  ContentView.swift
//  HabitTracker
//
//  Created by harsh Khandelwal on 23/10/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @ObservedObject var activities = Activities()
    
    @State private var showingActivity = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(activities.items){ item in
                    NavigationLink(destination: DetailView(activities: self.activities, activity: item)){
                        HStack{
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.title)
                                Text(item.description).foregroundColor(.blue)
                            }
                            Spacer()
                            Text("\(item.completedItems)").foregroundColor(.red)
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("Habit Tracker")
            .navigationBarItems(leading: EditButton(), trailing:
                                    Button(
                                        action: {
                                            self.showingActivity = true
                                        },
                                        label: {
                                            Image(systemName: "plus")
                                        }
                                    )
            )
            .sheet(isPresented: $showingActivity){
                AddActivity(activities: self.activities)
            }
        }
    }
    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
