//
//  ImagePickers.swift
//  Instafilter
//
//  Created by harsh Khandelwal on 22/11/21.
//

/*
 -> Wrapping a UIKit view controller requires us to create a struct that conforms to the UIViewControllerRepresentable protocol. This builds on View, which means the struct we’re defining can be used inside a SwiftUI view hierarchy, however we don’t provide a body property because the view’s body is the view controller itself – it just shows whatever UIKit sends back.

 -> Conforming to UIViewControllerRepresentable does require us to implement two methods: one called makeUIViewController(), which is responsible for creating the initial view controller, and another called updateUIViewController(), which is designed to let us update the view controller when some SwiftUI state changes.
 /// The reason the methods are long is because SwiftUI needs to know what type of view controller our struct is wrapping, so if we just straight up tell Swift that type Xcode will help us do the rest.
 
 Lets take a neat shortcut
 */

import SwiftUI
import Foundation

struct ImagePickers: UIViewControllerRepresentable {
//    typealias UIViewControllerType = UIImagePickerController
    //That isn’t enough code to compile correctly, but when Xcode shows an error saying “Type ImagePicker does not conform to protocol UIViewControllerRepresentable”, please click the red and white circle to the left of the error and select “Fix”.
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
//        We aren’t going to be using updateUIViewController(), so you can just delete the “code” line from there so that the method is empty.
    }
    //those methods are actually enough for Swift to figure out the view controller type so you can delete the typealias line.
    
    
}
