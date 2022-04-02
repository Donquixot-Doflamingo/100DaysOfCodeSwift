//
//  DetailUserView.swift
//  FriendsFace
//
//  Created by harsh Khandelwal on 18/11/21.
//

import SwiftUI

struct DetailUserView: View {
    
    var user : User
    var users : Users
    
    @State private var isShowingFriendList = false
    
    var body: some View {
        Form{
            Section(header: Text("Name")){
                Text(user.name)
            }
            
            Section(header: Text("Age")){
                Text("\(user.age)")
            }
            
            Section(header: Text("Company")){
                Text(user.company)
            }
            
            Section(header: Text("Is Activity")){
                Text(user.checkIsActive)
            }
            
            Section(header: Text("Switch to show friends")){
                Toggle(isOn: $isShowingFriendList){
                    Text("Show \(user.name)'s friends")
                }
            }
            
            if isShowingFriendList{
                Section(header: Text("\(user.name)'s friends")){
                    NavigationLink(destination: FriendsListView(user: self.user, users: self.users)){
                        Text("\(user.name)'s friends")
                    }
                }
            }
        }
        .navigationBarTitle(Text("User: \(user.name)"), displayMode: .inline)
    }
}

struct DetailUserView_Previews: PreviewProvider {
    static var previews: some View {
        DetailUserView(user: User(id: "ID", name: "name", age: 30, company: "COMPANY", isActive: true, friends: [Friend]()), users: Users())
    }
}
