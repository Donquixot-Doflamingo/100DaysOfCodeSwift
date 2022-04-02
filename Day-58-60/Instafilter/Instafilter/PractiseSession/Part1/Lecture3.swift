//
//  Lecture3.swift
//  Instafilter
//
//  _Created by harsh Khandelwal on 20/11/21._
//

import SwiftUI

// ****************** MARK: Showing multiple options with ActionSheet **********

/** ActionSheet Vs Alerts */
/*
 Visually alerts and action sheets are very different: on iPhones, alert appear in the center of the screen and must actively be dismissed by choosing a button, whereas action sheets slide up from the bottom, can contain multiple buttons, and can be dismissed by tapping on Cancel or by tapping outside of the action sheet.
 
 Apart from their presentation and differing numbers of buttons, action sheets and alerts share a lot of functionality. Both are created by attaching a modifier to our view hierarchy – alert() for alerts and actionSheet() for action sheets – both get shown automatically by SwiftUI when a condition is true, both use the same kind of button, and both have some built-in default styles for those buttons: default(), cancel(), and destructive().
 */
struct Lecture3: View {
    
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white

    var body: some View {
        Text("Hello, World!")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                self.showingActionSheet = true
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Change background"), message: Text("Select a new color"), buttons: [
                        .default(Text("Red")) { self.backgroundColor = .red },
                        .default(Text("Green")) { self.backgroundColor = .green },
                        .default(Text("Blue")) { self.backgroundColor = .blue },
                        .cancel()
                       ])
            }
    }
}

struct Lecture3_Previews: PreviewProvider {
    static var previews: some View {
        Lecture3()
    }
}
