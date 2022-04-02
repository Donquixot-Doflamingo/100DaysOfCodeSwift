//
//  Lecture4.swift
//  Instafilter
//
//  Created by harsh Khandelwal on 20/11/21.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

// MARK: *************** Integrating Core Image with SwiftUI
struct Lecture4: View {
    
    @State private var image: Image?

/* ** MARK: Apart from SwiftUI’s Image view, the three other image types are:

     1. UIImage, which comes from UIKit. This is an extremely powerful image type capable of working with a variety of image types, including bitmaps (like PNG), vectors (like SVG), and even sequences that form an animation. UIImage is the standard image type for UIKit, and of the three it’s closest to SwiftUI’s Image type.
     2. CGImage, which comes from Core Graphics. This is a simpler image type that is really just a two-dimensional array of pixels.
     3. CIImage, which comes from Core Image. This stores all the information required to produce an image but doesn’t actually turn that into pixels unless it’s asked to. Apple calls CIImage “an image recipe” rather than an actual image.
 
     MARK: There is some interoperability between the various image types:

    --> We can create a UIImage from a CGImage, and create a CGImage from a UIImage
    --> We can create a CIImage from a UIImage and from a CGImage, and can create a CGImage from a CIImage
    --> We can create a SwiftUI Image from both a UIImage and a CGImage
*/
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            }
            .onAppear(perform: loadImage)
    }
/*  We’re going to change loadImage() so that it creates a UIImage from our example image, then manipulate it using Core Image. More specifically, we’ll start with two tasks:
 
    1. We need to load our example image into a UIImage, which has an initializer called UIImage(named:) to load images from our asset catalog. It returns an optional UIImage because we might have specified an image that doesn’t exist.
    2. We’ll convert that into a CIImage, which is what Core Image wants to work with.
 */
    func loadImage() {
        //image = Image("Example")
        guard let inputImage = UIImage(named: "Example") else { return }
        let beginImage = CIImage(image: inputImage)
        //The next step will be to create a Core Image context and a Core Image filter. Filters are the things that do the actual work of transforming image data somehow, such as blurring it, sharpening it, adjusting the colors, and so on, and contexts handle converting that processed data into a CGImage we can work with so import some files
        
        let context = CIContext()
        
        //Example - 1
//        let currentFilter = CIFilter.sepiaTone()
//        currentFilter.inputImage = beginImage
//        currentFilter.intensity = 0.5
        
        // Example - 2
//        let currentFilter = CIFilter.pixellate()
//        currentFilter.inputImage = beginImage
//        currentFilter.scale = 100
        
        //Example - 3
//        let currentFilter = CIFilter.crystallize()
//        currentFilter.inputImage = beginImage
//        currentFilter.radius = 200
        
        // there was bug in above code so peiople used to do this
//        let currentFilter = CIFilter.crystallize()
//        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
//        currentFilter.radius = 200
        
//        kCIInputImageKey is a special constant that specifies the input image for a filter, and if you dig into it a little you’ll see that it’s actually a string – Core Image was, and still is behind the scenes, a completely stringly typed API.
        
    /*
         This becomes more apparent when you realize that only some of Apple’s Core Image filters were spruced up with the new, Swifty API. For example, if you want to apply a twirl distortion you need to use the old API, which is quite painful:

        -> We create a CIFilter instance using the exact name of a filter.
        -> We need to set its values by calling setValue() repeatedly, each time using different keys.
        -> Because CIFilter isn’t a specific filter, Swift will allow us to send in values that aren’t supported by the filter.
    */
        guard let currentFilter = CIFilter(name: "CITwirlDistortion") else { return }
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter.setValue(300, forKey: kCIInputRadiusKey)
        currentFilter.setValue(CIVector(x: inputImage.size.width / 2 - 100, y: inputImage.size.height / 2 + 100), forKey: kCIInputCenterKey)
        
        //Tip: CIVector is Core Image’s way of storing points and directions.
        
        /*
         we need to convert the output from our filter to a SwiftUI Image that we can display in our view. This is where we need to lean on all four image types at once, because the easiest thing to do is:

            -> Read the output image from our filter, which will be a CIImage. This might fail, so it returns an optional.
            -> Ask our context to create a CGImage from that output image. This also might fail, so again it returns an optional.
            -> Convert that CGImage into a UIImage.
            -> Convert that UIImage into a SwiftUI Image.
        */
        
        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }

        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage: cgimg)

            // and convert that to a SwiftUI image
            image = Image(uiImage: uiImage)
        }
    }
}

struct Lecture4_Previews: PreviewProvider {
    static var previews: some View {
        Lecture4()
    }
}
