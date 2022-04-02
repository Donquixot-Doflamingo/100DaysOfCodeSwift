//
//  Lecture5.swift
//  Instafilter
//
//  Created by harsh Khandelwal on 22/11/21.
//

import SwiftUI
// MARK: ***************** Wrapping a UIViewController in a SwiftUI view

///                            Things to know beforehand
/*
 -> First, UIKit has a class called UIView, which is the parent class of all views in the layouts. So, labels, buttons, text fields, sliders, and so on – those are all views.
 -> Second, UIKit has a class called UIViewController, which is designed to hold all the code to bring views to life. Just like UIView, UIViewController has many subclasses that do different kinds of work.
 -> Third, UIKit uses a design pattern called delegation to decide where work happens. So, when it came to deciding how our code should respond to a text field’s value changing, we’d create a custom class with our functionality and make that the delegate of our text field.
     */
struct Lecture5: View {
    // REFER TO IMAGEPICKER.SWIFT FILE
    @State private var image: Image?
    @State private var showingImagePicker = false

     var body: some View {
         VStack {
             image?
                 .resizable()
                 .scaledToFit()

             Button("Select Image") {
                self.showingImagePicker = true
             }
         }
         .sheet(isPresented: $showingImagePicker) {
             ImagePickers()
         }
     }
}

struct Lecture5_Previews: PreviewProvider {
    static var previews: some View {
        Lecture5()
    }
}
