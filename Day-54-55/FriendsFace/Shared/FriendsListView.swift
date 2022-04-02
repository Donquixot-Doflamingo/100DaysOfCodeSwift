//
//  FriendsListView.swift
//  FriendsFace
//
//  Created by harsh Khandelwal on 18/11/21.
//

import SwiftUI

struct FriendsListView: View {
    
    var user : User
    var users : Users
    
    var body: some View {
        List(user.friends){ friend in
            NavigationLink(destination: DetailUserView(user: self.users.findUser(string: friend.id), users: self.users)){
                VStack(alignment: .leading, spacing: nil){
                    Text(friend.name)
                }
            }
        }
        .navigationBarTitle("\(user.name)'s friends" , displayMode: .inline)
    }
}

struct FriendsListView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsListView(user: User(id: "ID", name: "name", age: 30, company: "COMPANY", isActive: true, friends: [Friend]()), users: Users())
    }
}
