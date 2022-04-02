//
//  ImagePicker.swift
//  Instafilter
//
//  Created by harsh Khandelwal on 23/11/21.
//

import Foundation
import SwiftUI
import Foundation
// ***************************** MARK: Using coordinators to manage SwiftUI view controllers

/*
 SwiftUI’s coordinators are designed to act as delegates for UIKit view controllers. Remember, “delegates” are objects that respond to events that occur elsewhere. For example, UIKit lets us attach a delegate object to its text field view, and that delegate will be notified when the user types anything, when they press return, and so on. This meant that UIKit developers could modify the way their text field behaved without having to create a custom text field type of their own.
 */

struct ImagePickerCoordinators: UIViewControllerRepresentable {
    
    //What we need here is SwiftUI’s @Binding property wrapper, which allows us to create a binding from ImagePicker up to whatever created it. This means we can set the binding value in our image picker and have it actually update a value being stored somewhere else – in ContentView, for example.
    @Binding var image: UIImage?
    /*
     While you’re there, we also want to dismiss this view when an image is chosen. Right now we aren’t handling image selection at all, so we get UIKit’s default dismissing behavior, but as soon as we inject some custom functionality we need to handle dismissal by hand.

     So, add this second property to ImagePicker so we can dismiss the view programmatically:
     */
    @Environment(\.presentationMode) var presentationMode
    
    class Coordinators : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        /*
         That does three things:

         1. It makes the class inherit from NSObject, which is the parent class for almost everything in UIKit. NSObject allows Objective-C to ask the object what functionality it supports at runtime, which means the image picker can say things like “hey, the user selected an image, what do you want to do?”
         2. It makes the class conform to the UIImagePickerControllerDelegate protocol, which is what adds functionality for detecting when the user selects an image. (NSObject lets Objective-C check for the functionality; this protocol is what actually provides it.)
         3. It makes the class conform to the UINavigationControllerDelegate protocol, which lets us detect when the user moves between screens in the image picker.
         */
        
        /* MARK: @Binding var image: UIImage? for reading this in ccoordinator
         we just added those properties to ImagePicker, but we need them inside our Coordinator class because that’s the one that will be informed when an image was selected.

         Rather than just pass the data down one level, a better idea is to tell the coordinator what its parent is, so it can modify values there directly. That means adding an ImagePicker property and associated initializer to the Coordinator class
         */
        
        var parent: ImagePickerCoordinators

        init(_ parent: ImagePickerCoordinators) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            //That method receives a dictionary where the keys are of the type UIImagePickerController.InfoKey, and the values are of the type Any. It’s our job to dig through that to find the image that was selected, assign it to our parent, then dismiss the image picker.
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()

        }
    }
    // as swiftUI won't automatically use the class Coordinators we have to make a function which calls it whenever we need it
    func makeCoordinator() -> Coordinators {
        Coordinators(self)
    }

    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        //The next step is to tell the UIImagePickerController that when something happens it should tell our coordinator. This takes just one line of code in makeUIViewController(), so add this directly before the return picker line:
        picker.delegate = context.coordinator
        /*
         That code won’t compile, but before we fix it I want to spend just a moment digging in to what just happened. We don’t call makeCoordinator() ourselves; SwiftUI calls it automatically when an instance of ImagePicker is created. Even better, SwiftUI automatically associated the coordinator it created with our ImagePicker struct, which means when it calls makeUIViewController() and updateUIViewController() it will automatically pass that coordinator object to us.
         So, the line of code we just wrote tells Swift to use the coordinator that just got made as the delegate for the UIImagePickerController. This means any time something happens inside the image picker controller – i.e., when the user selects an image – it will report that action to our coordinator.
         The reason our code doesn’t compile is that Swift is checking that our coordinator class is capable of acting as a delegate for UIImagePickerController, finding that it isn’t, and so is refusing to build our code any further. To fix this we need to modify our Coordinator class from this:
         class Coordinator {
         
         To this:
         class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

         */
        return picker
        
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    
}
