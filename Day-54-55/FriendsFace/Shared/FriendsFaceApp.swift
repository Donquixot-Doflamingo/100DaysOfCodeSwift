//
//  FriendsFaceApp.swift
//  Shared
//
//  Created by harsh Khandelwal on 16/11/21.
//

import SwiftUI

@main
struct FriendsFaceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
