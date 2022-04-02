//
//  Lecture3.swift
//  CoreDataProject
//
//  Created by harsh Khandelwal on 01/11/21.
//

import SwiftUI

struct Lecture3: View {
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("Save"){
//            it’s also common to bulk your saves together so that you save everything at once, which has a lower performance impact. In fact, Apple specifically states that we should always check for uncommitted changes before calling save(), to avoid making Core Data do work that isn’t required.
            if self.moc.hasChanges{
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
