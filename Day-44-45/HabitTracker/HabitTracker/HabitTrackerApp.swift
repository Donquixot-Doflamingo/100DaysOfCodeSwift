//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by harsh Khandelwal on 23/10/21.
//

import SwiftUI

@main
struct HabitTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
