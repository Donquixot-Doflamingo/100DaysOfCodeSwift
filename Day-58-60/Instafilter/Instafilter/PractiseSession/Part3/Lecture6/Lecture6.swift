//
//  Lecture6.swift
//  Instafilter
//
//  Created by harsh Khandelwal on 23/11/21.
//

import SwiftUI
// ****************************** MARK: Using coordinators to manage SwiftUI view controllers
struct Lecture6: View {
    //To integrate our ImagePicker view into that we need to start by adding another @State image property that can be passed into the picker:
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
            /*
             Finally, we need to change our sheet() modifier in two ways:
             
             -> We need to pass the inputImage property into our image picker, so it will be updated when the image is selected.
             -> We need to call our new loadImage() method when the sheet is dismissed.
            */
            
            ImagePickerCoordinators(image: self.$inputImage)
        }
    }
    //Next, we need a method we can call when that property changes. Remember, we can’t use a plain property observer here because Swift will ignore it, so instead we’ll write a method that checks whether inputImage has a value, and if it does uses it to assign a new Image view to the image property.
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct Lecture6_Previews: PreviewProvider {
    static var previews: some View {
        Lecture6()
    }
}

/* MARK: SUM UP OF COMPLETE PROCESS:THE COODINATORS
 -> We created a SwiftUI view that conforms to UIViewControllerRepresentable.
 -> We gave it a makeUIViewController() method that created some sort of UIViewController, which in our example was a UIImagePickerController.
 -> We added a nested Coordinator class to act as a bridge between the UIKit view controller and our SwiftUI view.
 -> We gave that coordinator a didFinishPickingMediaWithInfo method, which will be triggered by UIKit when an image was selected.
 -> Finally, we gave our ImagePicker an @Binding property so that it can send changes back to a parent view.
 */
