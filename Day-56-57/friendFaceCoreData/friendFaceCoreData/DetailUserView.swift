//
//  DetailUserView.swift
//  friendFaceCoreData
//
//  Created by harsh Khandelwal on 18/11/21.
//

import SwiftUI

struct DetailUserView: View {
    
    var fetchRequest: FetchRequest<User>
    var user : User? { fetchRequest.wrappedValue.first}
    
    var body: some View {
        VStack{
            UserView(user: user!)
        }
    }
    init(userId: String){
        fetchRequest = FetchRequest<User>(entity: User.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K == %@", "id", userId))
    }
}

//struct DetailUserView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailUserView()
//    }
//}
