//
//  Lecture1.swift
//  BucketList
//
//  Created by harsh Khandelwal on 26/11/21.
//

//MARK:                     Adding conformance to Comparable for custom types

import SwiftUI

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName > rhs.lastName
    }
}

struct Lecture1: View {
    
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ]
    //but we can't add sorting here directly as the swift don't know whether to sort it by first or last name so to sort it we can do is
//        .sorted{
//            $0.lastName < $1.lastName
//        }
/*  but this isn't that helpful as
     First, this is model data, by which I mean that it’s affecting the way we work with the User struct. That struct and its properties are our data model, and in a well-developed application we don’t really want to tell the model how it should behave inside our SwiftUI code. SwiftUI represents our view, i.e. our layout, and if we put model code in there then things get confused.
     
     Second, what happens if we want to sort User arrays in multiple places? You might copy and paste the closure once or twice, before realizing you’re just creating a problem for yourself: if you end up changing your sorting logic so that you also use firstName if the last name is the same, then you need to search through all your code to make sure all the closures get updated.
     
     Swift has a better solution. Arrays of integers get a simple sorted() method with no parameters because Swift understands how to compare two integers. In coding terms, Int conforms to the Comparable protocol, which means it defines a function that takes two integers and returns true if the first should be sorted before the second.
     
     We can make our own types conform to Comparable, and when we do so we also get a sorted() method with no parameters. This takes two steps:
     
     -> Add the Comparable conformance to the definition of User.
     -> Add a method called < that takes two users and returns true if the first should be sorted before the second.
*/
    
    // now after solving adding the Comparable property we can directly use sorting like this
        .sorted()
    let values = [1, 5, 3, 6, 2, 9].sorted()

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            List(values, id: \.self) {
                Text(String($0))
            }
            List(users) { user in
                Text("\(user.lastName), \(user.firstName)")
            }
        }
        
    }
}

struct Lecture1_Previews: PreviewProvider {
    static var previews: some View {
        Lecture1()
    }
}
