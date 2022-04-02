//
//  BucketListApp.swift
//  BucketList
//
//  Created by harsh Khandelwal on 26/11/21.
//

import SwiftUI

@main
struct BucketListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Lecture2()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
