//
//  Lecture3.swift
//  Bookworm
//
//  Created by harsh Khandelwal on 29/10/21.
//

import SwiftUI

/*
 First, the basics: Core Data is an object graph and persistence framework, which is a fancy way of saying it lets us define objects and properties of those objects, then lets us read and write them from permanent storage. On the surface this sounds like using Codable and UserDefaults, but it’s much more advanced than that: Core Data is capable of sorting and filtering of our data, and can work with much larger data – there’s effectively no limit to how much data it can store. Even better, Core Data implements all sorts of more advanced functionality for when you really need to lean on it: data validation, lazy loading of data, undo and redo, and much more.
 
 Setting up Core Data requires two steps: creating what’s called a persistent container, which is what loads and saves the actual data from device storage, and injecting that into the SwiftUI environment so that all our views can access it.
 */

struct Lecture3: View {
    /*
     Retrieving information from Core Data is done using a fetch request – we describe what we want, how it should sorted, and whether any filters should be used, and Core Data sends back all the matching data. We need to make sure that this fetch request stays up to date over time, so that as students are created or removed our UI stays synchronized.
     
     it’s another property wrapper. This time it’s called @FetchRequest and it takes two parameters: the entity we want to query, and how we want the results to be sorted.
     */
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
//    Broken down, that creates a fetch request for our “Student” entity, applies no sorting, and places it into a property called students that has the the type FetchedResults<Student>.

    
    var body: some View {
        VStack {
            List {
                ForEach(students, id: \.id) { student in
                    Text(student.name ?? "Unknown")
                }
            }
            
            Button("Add") {
                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                let chosenFirstName = firstNames.randomElement()!
                let chosenLastName = lastNames.randomElement()!

                let student = Student(context: self.moc)
                student.id = UUID()
                student.name = "\(chosenFirstName) \(chosenLastName)"
                
                try? self.moc.save()
            }
        }
    }
}

struct Lecture3_Previews: PreviewProvider {
    static var previews: some View {
        Lecture3()
    }
}
