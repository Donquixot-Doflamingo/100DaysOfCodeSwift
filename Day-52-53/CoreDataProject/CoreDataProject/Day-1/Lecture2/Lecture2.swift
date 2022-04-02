//
//  Lecture2.swift
//  CoreDataProject
//
//  Created by harsh Khandelwal on 31/10/21.
//

import SwiftUI

/*
 There are two solutions to this: a fast and easy one that can sometimes end up being problematic, or a slightly slower solution that works better in the long term.

 First, let’s create an entity to work with: open your data model and create an entity called Movie with the attributes “title” (string), “director” (string), and “year” (an integer 16). Before you leave the data model editor, I’d like you to go to the View menu and choose Inspectors > Show Data Model Inspector, which brings up a pane on the right of Xcode containing more information about whatever you have selected right now.

 When you select Movie you’ll see a variety of data model options for that entity, but there’s one in particular I’d like you to look at: “Codegen”. This controls how Xcode generates the entity as a managed object class when we build our project, and by default it will be Class Definition. I’d like to change that to Manual/None, which gives us full control over how the class is made.
 Now that Xcode is no longer generating a Movie class for us to use in code, we can’t use it in code unless we actually make the class with some real Swift code. To do that, go to the Editor menu and choose Create NSManagedObject Subclass, make sure “CoreDataProject” is selected then press Next, then make sure Movie is selected and press Next again. You’ll be asked where Xcode should save its code, so please make sure you choose “CoreDataProject” with a yellow folder icon on its left, and select the CoreDataProject folder too. When you’re ready, press Create to finish the process.
 What we just did was ask Xcode to convert its generated code into actual Swift files that we can see and change, although keep in mind if you change the files Xcode generated for us then re-generate those files, your changes will be lost.
 */

struct Lecture2: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Lecture2_Previews: PreviewProvider {
    static var previews: some View {
        Lecture2()
    }
}
