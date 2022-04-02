//
//  LoadedUser.swift
//  friendFaceCoreData
//
//  Created by harsh Khandelwal on 18/11/21.
//

import Foundation
import SwiftUI

struct LoadedUser: Codable, Identifiable{
    var id : String?
    var name : String?
    var age : Int
    var company : String?
    var isActive : Bool
    var friends : [LoadedFriend]
}

struct LoadedFriend: Codable, Identifiable{
    var id: String?
    var name : String?
}
