//
//  Activity.swift
//  HabitTracker
//
//  Created by harsh Khandelwal on 23/10/21.
//

import Foundation
import SwiftUI

class Activities : ObservableObject{
    @Published var items = [Activity]()
    
    func saveActivities(){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items){
            UserDefaults.standard.set(encoded, forKey: "items")
        }
    }
    init(){
        if let items = UserDefaults.standard.data(forKey: "items"){
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([Activity].self, from: items){
                self.items = decoded
                return
            }
        }
            
        self.items = []
    }
    
}

struct Activity : Identifiable, Codable{
    
    let id = UUID()
    var name : String
    var description : String
    var completedItems : Int
    
    static func == (lhs : Activity, rhs : Activity) -> Bool{
        /* MARK: Explanation of static function used in it
            We wont to compare one Activity object and another Activity object, and say, This is two Activity object is EQUAL or NOT EQUAL static func in
            our example have access to the Object and all properties  in our object. And we must say Xcode what properties in two object, he must compare.
            And through our static func we take "id" properties from two Activity object and if firtsActiviti.id (lhs.id)  the same secondsActivity.id(rhs.id)
            if the same return true if not return false
         
             If we wont to compare a simple
             let firstAge = 10
             let secondAge = 20
         */
        return lhs.id == rhs.id
    }
}
