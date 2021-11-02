//
//  WeSplitApp.swift
//  WeSplit
//
//  Created by harsh Khandelwal on 24/09/21.
//

import SwiftUI

@main
struct WeSplitApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
