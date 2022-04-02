//
//  UserView.swift
//  friendFaceCoreData
//
//  Created by harsh Khandelwal on 18/11/21.
//

import SwiftUI

struct UserView: View {
    
    @State private var isShowingFriendList = false
    
    var user : User
    
    var body: some View {
        Form{
            Section(header: Text("Name")){
                Text(user.wrappedName)
            }
            
            Section(header: Text("Age")){
                Text("\(user.wrappedAge)")
            }
            
            Section(header: Text("Company")){
                Text(user.wrappedCompany)
            }
            
            Section(header: Text("Is Activity")){
                Text(user.checkIsActive)
            }
            
            Section(header: Text("Switch to show friends")){
                Toggle(isOn: $isShowingFriendList){
                    Text("Show \(user.wrappedName)'s friends")
                }
            }
            
            if isShowingFriendList{
                Section(header: Text("\(user.wrappedName)'s friends")){
                    NavigationLink(destination: FriendsListView(friends: self.user.friendsArray)){
                        Text("Show \(user.wrappedName)'s friends")
                    }
                }
            }
        }
    }
}

//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserView()
//    }
//}
