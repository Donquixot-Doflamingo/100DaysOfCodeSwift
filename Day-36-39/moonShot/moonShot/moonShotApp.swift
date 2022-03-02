//
//  moonShotApp.swift
//  moonShot
//
//  Created by harsh Khandelwal on 15/10/21.
//

import SwiftUI

@main
struct moonShotApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
