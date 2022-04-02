//
//  User.swift
//  FriendsFace
//
//  Created by harsh Khandelwal on 18/11/21.
//

import Foundation
import SwiftUI

struct User: Codable, Identifiable{
    var id : String
    var name : String
    var age : Int
    var company : String
    var isActive : Bool
    var friends : [Friend]
    var checkIsActive : String{
        return self.isActive ? "🟢" : "🔴"
    }
}

struct Friend: Codable, Identifiable{
    var id: String
    var name : String
}
