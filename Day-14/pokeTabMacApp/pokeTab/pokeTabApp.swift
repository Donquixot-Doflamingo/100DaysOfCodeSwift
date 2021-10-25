//
//  pokeTabApp.swift
//  pokeTab
//
//  Created by harsh Khandelwal on 19/09/21.
//

import SwiftUI

@main
struct pokeTabApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            PokemonList()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
