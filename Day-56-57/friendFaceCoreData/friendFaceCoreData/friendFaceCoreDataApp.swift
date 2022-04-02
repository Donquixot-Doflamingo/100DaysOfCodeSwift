//
//  friendFaceCoreDataApp.swift
//  friendFaceCoreData
//
//  Created by harsh Khandelwal on 18/11/21.
//

import SwiftUI

@main
struct friendFaceCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
