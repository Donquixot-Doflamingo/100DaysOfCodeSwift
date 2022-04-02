//
//  Users.swift
//  FriendsFace
//
//  Created by harsh Khandelwal on 18/11/21.
//

import Foundation
import SwiftUI

class Users : ObservableObject{
    @Published var arrayOfUsers = [User]()
    
    init(){
        let stringURL = "https://www.hackingwithswift.com/samples/friendface.json"
        
        guard let url = URL(string: stringURL) else{
            print("Haha, Lol Nice try though")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else{
                print("No response from the data \(error?.localizedDescription ?? "No data response")")
                return
            }
            
            if let decoderUser = try? JSONDecoder().decode([User].self, from: data){
                self.arrayOfUsers = decoderUser
            }
        }.resume()
        
    }
    
    func findUser(string : String) -> User{
        guard let firstUser = self.arrayOfUsers.first(where: { (oneUser) -> Bool in
            oneUser.id == string
        }) else{
            return self.arrayOfUsers.first!
        }
        return firstUser
    }
}
