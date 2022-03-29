//
//  Lecture1.swift
//  Bookworm
//
//  Created by harsh Khandelwal on 29/10/21.
//

import SwiftUI

struct PushButton: View {
    let title: String
//    this is where @Binding comes in: it allows us to create a two-way connection between PushButton and whatever is using it, so that when one value changes the other does too.
    @Binding var isOn: Bool

    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]

    var body: some View {
        Button(title) {
            self.isOn.toggle()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct Lecture1: View {
    @State private var remeberMe = false
    var body: some View {
        VStack {
            PushButton(title: "Remember Me", isOn: $remeberMe)
            Text(remeberMe ? "On" : "Off")
            Toggle(isOn: $remeberMe){
                Text("Remember Me")
            }
                }
    }
}

struct Lecture1_Previews: PreviewProvider {
    static var previews: some View {
        Lecture1()
    }
}
