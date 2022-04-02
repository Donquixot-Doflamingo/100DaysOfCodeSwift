//
//  FriendsListView.swift
//  friendFaceCoreData
//
//  Created by harsh Khandelwal on 18/11/21.
//

import SwiftUI

struct FriendsListView: View {
    
    var friends: [Friend]
    var body: some View {
        List(){
            ForEach(friends, id: \.wrappedId){ friend in
                NavigationLink(destination: DetailUserView(userId: friend.wrappedId)){
                    VStack(alignment: .leading, spacing: nil){
                        Text(friend.wrappedName)
                    }
                }
            }
        }
    }
}
//
//struct FriendsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendsListView()
//    }
//}
