//
//  wordScrambleApp.swift
//  wordScramble
//
//  Created by harsh Khandelwal on 03/10/21.
//

import SwiftUI

@main
struct wordScrambleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
