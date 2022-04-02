//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by harsh Khandelwal on 31/10/21.
//

import CoreData
import SwiftUI

@main
struct CoreDataProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            challenge()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
}
