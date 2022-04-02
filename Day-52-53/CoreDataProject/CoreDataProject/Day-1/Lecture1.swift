//
//  Lecture1.swift
//  CoreDataProject
//
//  Created by harsh Khandelwal on 31/10/21.
//

import SwiftUI

/*
 When we use \.self as an identifier, we mean “the whole object”, but in practice that doesn’t mean much – a struct is a struct, so it doesn’t have any sort of specific identifying information other than its contents. So what actually happens is that Swift computes the hash value of the struct, which is a way of representing complex data in fixed-size values, then uses that hash as an identifier.
 
 Hash values can be generated in any number of ways, but the concept is identical for all hash-generating functions:

 1. Regardless of the input size, the output should be the same fixed size.
 2. Calculating the same hash for an object twice in a row should return the same value.

 Those two sound simple, but think about it: if we get the hash of “Hello World” and the hash of the complete works of Shakespeare, both will end up being the same size. This means it’s not possible to convert the hash back into its original value – we can’t convert 40 seemingly random hexadecimal letters and numbers into the complete works of Shakespeare.
 
 All this matters because when Xcode generates a class for our managed objects, it makes that class conform to Hashable, which is a protocol that means Swift can generate hash values for it, which in turn means we can use \.self for the identifier. This is also why String and Int work with \.self: they also conform to Hashable.
 */

struct Student: Hashable {
    let name: String
}

struct Lecture1: View {
    
    let students = [Student(name: "Harry Potter"), Student(name: "Hermione Granger"), Student(name: "Hermione Granger")]

    var body: some View {
        VStack {
            //f an object conforms to the Identifiable protocol, then SwiftUI will automatically use its id property for uniquing. If we don’t use Identifiable, then we can use a keypath for a property we know to be unique, such as a book’s ISBN number. But if we don’t conform to Identifiable and don’t have a keypath that is unique, we can often use \.self.
            List {
                ForEach([2, 4, 6, 8, 10], id: \.self) {
                    Text("\($0) is even")
                }
            }
            /*
            Now, you might think this leads to a problem: if we create two Core Data objects with the same values, they’ll generate the same hash, and we’ll hit animation problems. However, Core Data does something really smart here: the objects it creates for us actually have a selection of other properties beyond those we defined in our data model, including one called the object ID – an identifier that is unique to that object, regardless of what properties it contains. These IDs are similar to UUID, although Core Data generates them sequentially as we create objects.

            So, \.self works for anything that conforms to Hashable, because Swift will generate the hash value for the object and use that to uniquely identify it. This also works for Core Data’s objects because they already conform to Hashable.
             */
            List(students, id: \.self) { student in
                        Text(student.name)
            }
        }
    }
}

struct Lecture1_Previews: PreviewProvider {
    static var previews: some View {
        Lecture1()
    }
}
