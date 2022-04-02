//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by harsh Khandelwal on 31/10/21.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var year: Int16
    @NSManaged public var character: String
    
    public var wrappedTitle: String {
        title ?? "Unknown Title"
    }
    
    /*
     In that tiny slice of code you can see three things:

     This is where our optional problem stems from.
     year is not optional, which means Core Data will assume a default value for us.
     It uses @NSManaged on all three properties.
     @NSManaged is not a property wrapper – this is much older than property wrappers in SwiftUI. Instead, this reveals a little of how Core Data works internally: rather than those values actually existing as properties in the class, they are really just there to read and write from a dictionary that Core Data uses to store its information. When we read or write the value of a property that is @NSManaged, Core Data catches that and handles it internally – it’s far from a simple Swift string.
     */
    
    /*
     And you know what? That will absolutely work. You can make Movie objects with just the same code as before, use fetch requests to query them, save their managed object contexts, and more, all with no problems.

     However, you might notice something strange: even though our properties aren’t optional any more, it’s still possible to create an instance of the Movie class without providing those values. This ought to be impossible: these properties aren’t optional, which means they must have values all the time, and yet we can create them without values.

     What’s happening here is a little of that @NSManaged magic leaking out – remember, these aren’t real properties, and as a result @NSManaged is letting us do things that ought not to work. The fact that it does work is neat, and for small Core Data projects and/or learners I think removing the optionality is a great idea. However, there’s a deeper problem: Core Data is lazy.
     
     Remember Swift’s lazy keyword, and how it lets us delay work until we actually need it? Core Data does much the same thing, except with data: sometimes it looks like some data has been loaded when it really hasn’t been because Core Data is trying to minimize its memory impact. Core Data calls these faults, in the sense of a “fault line” – a line between where something exists and where something is just a placeholder.
     
     We don’t need to do any special work to handle these faults, because as soon as we try to read them Core Data transparently fetches the real data and sends it back – another benefit of @NSManaged. However, when we start futzing with the types of Core Data’s properties we risk exposing its peculiar underbelly. This thing specifically does not work the way Swift expects, and if we try to circumvent that then we’re pretty much inviting problems – values we’ve said definitely won’t be nil might suddenly be nil at any point.
     
     Instead, you might want to consider adding computed properties that help us access the optional values safely, while also letting us store your nil coalescing code all in one place.
     */

}

extension Movie : Identifiable {

}
