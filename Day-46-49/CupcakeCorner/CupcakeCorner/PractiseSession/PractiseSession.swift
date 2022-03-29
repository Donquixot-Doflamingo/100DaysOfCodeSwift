//
//  PractiseSession.swift
//  CupcakeCorner
//
//  Created by harsh Khandelwal on 26/10/21.
//

import SwiftUI

struct PractiseSession: View {
    var body: some View {
        List {
            Section(header: Text("Day 1")){
                NavigationLink(destination: Lecture1()){
                    Text("Merging codable and @published")
                }
                NavigationLink(destination: Lecture2()){
                    Text("Loading data & converting to swiftOjects from API")
                }
                NavigationLink(destination: Lecture3()){
                    Text("using Disable modifier for form")
                }
            }
        }
    }
}

struct PractiseSession_Previews: PreviewProvider {
    static var previews: some View {
        PractiseSession()
    }
}
