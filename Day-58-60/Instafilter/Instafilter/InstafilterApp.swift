//
//  InstafilterApp.swift
//  Instafilter
//
//  Created by harsh Khandelwal on 19/11/21.
//

import SwiftUI

@main
struct InstafilterApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
