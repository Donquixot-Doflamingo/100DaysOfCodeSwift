//
//  DrawingApp.swift
//  Drawing
//
//  Created by harsh Khandelwal on 19/10/21.
//

import SwiftUI

@main
struct DrawingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
