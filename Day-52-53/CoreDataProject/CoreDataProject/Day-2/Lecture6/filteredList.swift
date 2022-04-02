//
//  filteredList.swift
//  CoreDataProject
//
//  Created by harsh Khandelwal on 01/11/21.
//

import CoreData
import SwiftUI

struct filteredList<T: NSManagedObject, Content: View>: View {
    
    @Environment(\.managedObjectContext) var moc
    
    
    //MARK: This is the way of defining where we have specifies the filtering of data and the element we want to filter
//    var fetchRequest: FetchRequest<Singer>
//    var singers: FetchedResults<Singer> { fetchRequest.wrappedValue }
//
//
//    var body: some View {
//        List(fetchRequest.wrappedValue, id: \.self) { singer in
//            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
//        }
//    }
//
//    init(filter: String) {
//        fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
//    }
    
    //MARK: This is the way of defining the filtering of data in generics format and more dynamically
    
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List{
            ForEach(fetchRequest.wrappedValue, id: \.self) { singer in
                self.content(singer)
            }.onDelete(perform: removeSinger(at:))
        }
    }
    
    func removeSinger(at offsets: IndexSet){
        for index in offsets {
            let singer = singers[index]
            moc.delete(singer)
            do{
                try moc.save()
            }
            catch{
                print("ERRORRRR!!!")
            }
        }
    }
    
    //MARK -: Chllenge 3.7 set parameters for : filteringType : FilterType
    //MARK -: Chllenge 1.2 set type [NSSortDescriptor] to the parameters : sortDiscriptors

    init(filterKey: String, filterValue: String, sortDiscriptors : [NSSortDescriptor], filteringType : FilterType ,@ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDiscriptors, predicate: NSPredicate(format: "%K \(filteringType.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
}
