//
//  GuessTheFlagApp.swift
//  GuessTheFlag
//
//  Created by harsh Khandelwal on 27/09/21.
//

import SwiftUI

@main
struct GuessTheFlagApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
