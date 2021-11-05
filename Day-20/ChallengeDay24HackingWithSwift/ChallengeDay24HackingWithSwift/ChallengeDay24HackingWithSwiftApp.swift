//
//  ChallengeDay24HackingWithSwiftApp.swift
//  ChallengeDay24HackingWithSwift
//
//  Created by harsh Khandelwal on 30/09/21.
//

import SwiftUI

@main
struct ChallengeDay24HackingWithSwiftApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
