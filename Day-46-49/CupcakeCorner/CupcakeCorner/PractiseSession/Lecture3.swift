//
//  Lecture3.swift
//  CupcakeCorner
//
//  Created by harsh Khandelwal on 26/10/21.
//

import SwiftUI
// to check that input in forms to make sure it’s valid before we proceed, we can use disabled(). This takes a condition to check, and if the condition is true then whatever it’s attached to won’t respond to user input – buttons can’t be tapped, sliders can’t be dragged, and so on. You can use simple properties here, but any condition will do: reading a computed property, calling a method, and so on,


struct Lecture3: View {
    
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account…")
                }
            }
        }
//        .disabled(username.isEmpty || email.isEmpty) or 
        .disabled(disableForm)
    }
}

struct Lecture3_Previews: PreviewProvider {
    static var previews: some View {
        Lecture3()
    }
}
