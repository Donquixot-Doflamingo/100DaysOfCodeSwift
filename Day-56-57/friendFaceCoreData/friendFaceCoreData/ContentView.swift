//
//  ContentView.swift
//  friendFaceCoreData
//
//  Created by harsh Khandelwal on 18/11/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc

    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var users : FetchedResults<User>

    var body: some View {
        NavigationView {
            List() {
                ForEach(users, id: \.id) { user in
                    NavigationLink(destination: DetailUserView(userId: user.wrappedId)){
                        HStack{
                            Text("\(user.checkIsActive)")
                            VStack(alignment: .leading, spacing: nil){
                                Text(user.wrappedName)
                                    .font(.headline)
                                Text("Age \(user.age)")
                            }
                        }
                    }
                }
                .onDelete(perform: remove(at:))
            }
            .navigationBarTitle(Text("User List"))
        }
        .onAppear{
            if self.users.isEmpty{
                print("Users are empty \(self.users)")
                Users.loadDataToCD(moc: self.moc)
            }
        }
    }
    
    func remove(at offsets : IndexSet){
        for index in offsets{
            let user = users[index]
            moc.delete(user)
            
            do{
                try moc.save()
            }
            catch{
                print("Could not save after delete")
            }
        }
        
//        for all in users{
//            moc.delete(all)
//        }
//        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
