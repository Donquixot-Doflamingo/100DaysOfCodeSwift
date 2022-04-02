//
//  Lecture4.swift
//  CoreDataProject
//
//  Created by harsh Khandelwal on 01/11/21.
//

import SwiftUI

struct Lecture4: View {
    
    @Environment(\.managedObjectContext) var moc

    @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>

    
    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }

            Button("Add") {
                let wizard = Wizard(context: self.moc)
                wizard.name = "Harry Potter"
            }

            Button("Save") {
                do {
                    try self.moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct Lecture4_Previews: PreviewProvider {
    static var previews: some View {
        Lecture4()
    }
}
