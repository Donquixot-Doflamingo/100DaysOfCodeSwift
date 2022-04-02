//
//  ContentView.swift
//  Shared
//
//  Created by harsh Khandelwal on 16/11/21.
//

import SwiftUI
import CoreData


struct ContentView: View {
    
    @ObservedObject var users = Users()
    
    var body: some View {
        NavigationView{
            List(users.arrayOfUsers){ user in
                NavigationLink(destination: DetailUserView(user: user, users: self.users)){
                    HStack{
                        Text("\(user.checkIsActive)")
                        VStack(alignment: .leading, spacing: nil){
                            Text(user.name)
                                .font(.headline)
                            Text("Age \(user.age)")
                        }
                    }
                }
            }
            .navigationBarTitle(Text("User List"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
