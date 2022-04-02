//
//  Lecture5.swift
//  CoreDataProject
//
//  Created by harsh Khandelwal on 01/11/21.
//

import SwiftUI

struct Lecture5: View {
    
///MARK:                                                                                                                            Filtering @FetchRequest using NSPredicate
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(
        
        /// to show the elements having the universe "Star Wars"
//        format: "universe == 'Star Wars'"
        
        /// to show the elements having the universe "Star Wars" but using operators, so we can add multiple values
//        format: "universe == %@", "Star Wars"
        
        /// to show the elements having the starteing letter of their "name" smaller than f
//        format: "name < %@", "F"
        
        /// to show the elements having the universe from any alues of these array
//        format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"]
        
        /// to show the elements having the beggiening letter with E
//        format: "name BEGINSWITH %@", "E"
        
        /// to show the elements having the e in any of the strings in name
//        format: "name BEGINSWITH[c] %@", "e"
        
        /// to show the elements having the names not beggeing from e
        format: "NOT name BEGINSWITH[c] %@", "e"
        )
    ) var ships: FetchedResults<Ship>

    
    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown name")
            }

            Button("Add Examples") {
                let ship1 = Ship(context: self.moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"

                let ship2 = Ship(context: self.moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"

                let ship3 = Ship(context: self.moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"

                let ship4 = Ship(context: self.moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"

                try? self.moc.save()
            }
        }
    }

}

struct Lecture5_Previews: PreviewProvider {
    static var previews: some View {
        Lecture5()
    }
}
