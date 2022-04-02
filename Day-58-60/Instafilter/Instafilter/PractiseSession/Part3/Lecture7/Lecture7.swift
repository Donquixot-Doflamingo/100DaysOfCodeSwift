//
//  Lecture7.swift
//  Instafilter
//
//  Created by harsh Khandelwal on 23/11/21.
//

import SwiftUI

// ************************************ MARK: How to save images to the user’s photo library

/*
 MARK: Before starting make the info.pllist as following due to privacy issues
 Before we write any code, I need you to make one small change to the Info.plist file for your project. You see, writing to the photo library is a protected operation, which means we can’t do it without explicit permission from the user.

iOS will take care of asking for permission and checking the response, but we need to provide a short string explaining to users why we want to write images in the first place. To do that, open Info.plist, right-click on some empty space, then choose Add Row. You’ll see a dropdown list of options to choose from – I’d like you to scroll down and select “Privacy - Photo Library Additions Usage Description”. For the value on its right, please enter the text “We want to save the filtered photo.”
 */

///. Now head back to the bottom


// we need some sort of class that inherits from NSObject. Inside there we need a method with a precise signature that’s marked with @objc, and we can then call that from UIImageWriteToSavedPhotosAlbum().

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}

struct Lecture7: View {
    
    @State private var inputImage: UIImage?
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
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePickerCoordinators(image: self.$inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        
        // To save image
        //Now turning the below code of and using the class to solve it
        //UIImageWriteToSavedPhotosAlbum(inputImage, nil, nil, nil)
    /*
         Those nil parameters matter, or at least the first two do: they tell Swift what method should be called when saving completes, which in turn will tell us whether the save operation succeeded or failed. If you don’t care about that then you’re done – passing nil for all three is fine. But remember: users can deny access to their photo library, so if you don’t catch the save error they’ll wonder why your app isn’t working properly.
         The reason it takes UIKit two parameters to know which function to call is because this code is old – way older than Swift, and in fact so old it even pre-dates Objective-C’s equivalent of closures. So instead, this uses a completely different way of referring to functions: in place of the first nil we should point to an object, and in place of the second nil we should point to the name of the method that should be called.
         
         MARK: both of those two parameters have their own complexities:

         -> The object we provide must be a class, and it must inherit from NSObject. This means we can’t point to a SwiftUI view struct.
         -> The method is provided as a method name, not an actual method. This method name was used by Objective-C to find the actual code at runtime, which could then be run. That method needs to have a specific signature (list of parameters) otherwise our code just won’t work.
         
         For performance reasons, Swift prefers not to generate code in a way that Objective-C can read – that whole “look up methods at runtime” thing was really neat, but also really slow. And so, when it comes to writing the method name we need to do two things:

         1. Mark the method using a special compiler directive called #selector, which asks Swift to make sure the method name exists where we say it does.
         2. Add an attribute called @objc to the method, which tells Swift to generate code that can be read by Objective-C.
         
         MARK: The fourth Parameter
         the first one is the image to save, the second one is an object that should be notified about the result of the save, the third one is the method on the object that should be run, and then there’s the fourth one. We aren’t going to be using it here, but you need to be aware of what it does: we can provide any sort of data here, and it will be passed back to us when our completion method is called.

         This is what UIKit calls “context”, and it helps you identify one image save operation from another. You can provide literally anything you want here, so UIKit uses the most hands-off type you can imagine: a raw chunk of memory that Swift makes no guarantees about whatsoever. This has its own special type name in Swift: UnsafeRawPointer.
    */
        /// Now head back to the class
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
}

struct Lecture7_Previews: PreviewProvider {
    static var previews: some View {
        Lecture7()
    }
}
