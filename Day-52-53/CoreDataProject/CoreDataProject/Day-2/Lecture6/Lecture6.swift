//
//  Lecture6.swift
//  CoreDataProject
//
//  Created by harsh Khandelwal on 01/11/21.
//

import SwiftUI

struct Lecture6: View {
                                        // MARK: Filtering data more dynamically
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    
    @State private var filteringStyle = FilterType.beginWidth
    
    var body: some View {
        VStack {
            // list of matching singers
            
//            filteredList(filter: lastNameFilter)
            
            filteredList(filterKey: "lastName", filterValue: lastNameFilter, sortDiscriptors: [], filteringType: FilterType(rawValue: filteringStyle.rawValue) ?? FilterType.beginWidth) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                try? self.moc.save()
            }

            Button("Show A") {
                self.lastNameFilter = "A"
            }

            Button("Show S") {
                self.lastNameFilter = "S"
            }
        }
    }
}

struct Lecture6_Previews: PreviewProvider {
    static var previews: some View {
        Lecture6()
    }
}
