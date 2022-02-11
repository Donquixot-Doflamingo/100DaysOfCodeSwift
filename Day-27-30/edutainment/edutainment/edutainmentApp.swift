//
//  edutainmentApp.swift
//  edutainment
//
//  Created by harsh Khandelwal on 06/10/21.
//

import SwiftUI

@main
struct edutainmentApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
