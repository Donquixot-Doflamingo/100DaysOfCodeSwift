//
//  CupcakeCornerApp.swift
//  CupcakeCorner
//
//  Created by harsh Khandelwal on 26/10/21.
//

import SwiftUI

@main
struct CupcakeCornerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentViewChallenge3()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
