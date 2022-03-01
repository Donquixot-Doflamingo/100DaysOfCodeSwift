//
//  EdutainmentGameApp.swift
//  EdutainmentGame
//
//  Created by harsh Khandelwal on 09/10/21.
//

import SwiftUI

@main
struct EdutainmentGameApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
