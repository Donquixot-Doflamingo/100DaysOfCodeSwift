//
//  iExpenseApp.swift
//  iExpense
//
//  Created by harsh Khandelwal on 12/10/21.
//

import SwiftUI

@main
struct iExpenseApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
