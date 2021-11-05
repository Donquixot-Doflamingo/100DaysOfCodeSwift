//
//  ContentView.swift
//  ChallengeDay24HackingWithSwift
//
//  Created by harsh Khandelwal on 30/09/21.
//

import SwiftUI
import CoreData

struct prominentTiles : ViewModifier{
    func body(content : Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View{
    func ProminentTiles() -> some View{
        self.modifier(prominentTiles())
    }
}

struct ContentView: View {
    var body: some View {
        Text("Item at").ProminentTiles()
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
