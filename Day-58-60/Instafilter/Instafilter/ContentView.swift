//
//  ContentView.swift
//  Instafilter
//
//  Created by harsh Khandelwal on 19/11/21.
//

import SwiftUI
import CoreData
import CoreImage
import CoreImage.CIFilterBuiltins

/* MARK: Challenges
 One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on.
 
 Try making the Save button show an error if there was no image in the image view.
 Make the Change Filter button change its title to show the name of the currently selected filter.
 Experiment with having more than one slider, to control each of the input keys you care about. For example, you might have one for radius and one for intensity.
 */

/* MARK: The first step in our project is to build the basic user interface, which for this app will be:

 1. A NavigationView so we can show our app’s name at the top.
 2. A large gray box saying “Tap to select a picture”, over which we’ll place their imported picture.
 3. An “Intensity” slider that will affect how strongly we apply our Core Image filters, stored as a value from 0.0 to 1.0.
 4. A “Save” button to write out the modified image to the user’s photo library.
 */

struct ContentView: View {

    @State private var image: Image?
    @State private var filterIntensity = 0.5
    
    // FOr Image picker Struct
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    // for working with filters
    @State private var currentFilter : CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    // for filter sheets
    @State private var showingFilterSheet = false
    
    // to save the images
    @State private var processedImage: UIImage?
    
    // MARK: Challenge 1.1 - alerts varialbe
    @State private var showingEmptyImage = false
    
    // MARK: Challenge 2.1 - filterTitle
    @State private var filterTitle = ""
    
    
    // MARK: Challenge 3.1 - filterRadius and filterScale
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        
        // MARK: Challenge 3.2 - filterRadius, filterScale bindings
        let radius = Binding<Double>(
            get: {
                self.filterRadius
            },
            set: {
                self.filterRadius = $0
                self.applyProcessing()
            }
        )
        let scale = Binding<Double>(
            get: {
                self.filterScale
            },
            set: {
                self.filterScale = $0
                self.applyProcessing()
            }
        )
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)

                /* MARK: this code might not run on smaller iOS versions
                     
                     if let image = image {
                         image
                             .resizable()
                             .scaledToFit()
                     } else {
                         Text("Tap to select a picture")
                             .foregroundColor(.white)
                             .font(.headline)
                     }
                     
                     However, if you try building that you’ll see it doesn’t work – you’ll get a fairly obscure error message along the lines of “Closure containing control flow statement cannot be used with function builder ViewBuilder”.

                     What Swift is trying to say is it has support for only a small amount of logic inside SwiftUI layouts – we can use if someCondition, but we can’t use if let, for, while, switch, and so on.

                     What’s actually happening here is that Swift is able to convert if someCondition into a special internal view type called ConditionalContent: it stores the condition and the true and false views, and can check it at runtime. However, if let creates a constant, and switch can have any number of cases, so neither can be used.
                */
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    
                    
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }

                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }.padding(.vertical)
                
                //MARK: 3.3 - Making slider for radius and scale
                
                HStack {
                    Text("Radius")
                    Slider(value: radius)
                }.padding(.vertical)
                
                HStack {
                    Text("Scale")
                    Slider(value: scale)
                }.padding(.vertical)

                HStack {
                    // MARK: Challenge 2.2 -> Displaying the filterTitle
                    Button("Change Filter from \(filterTitle)") {
                        self.showingFilterSheet = true
                    }

                    Spacer()

                    Button("Save") {
                        guard let processedImage = self.processedImage else {
                            print("No save image")
                            // MARK: Challenge 1.2 -> Selecting the time of alert trigger
                            showingEmptyImage = true
                            return }
                        
                        let saveImage = SaveImage()
                        
                        // to ccheck of if the image is actually save do or not and print accordingly
                        
                        saveImage.successHandler = {
                            print("Success!")
                        }
                        
                        saveImage.errorHandler = {
                            print("Oops: \($0.localizedDescription)")
                        }
                        saveImage.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet){
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")) { self.setFilter(CIFilter.crystallize()) },
                    .default(Text("Edges")) { self.setFilter(CIFilter.edges()) },
                    .default(Text("Gaussian Blur")) { self.setFilter(CIFilter.gaussianBlur()) },
                    .default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate()) },
                    .default(Text("Sepia Tone")) { self.setFilter(CIFilter.sepiaTone()) },
                    .default(Text("Unsharp Mask")) { self.setFilter(CIFilter.unsharpMask()) },
                    .default(Text("Vignette")) { self.setFilter(CIFilter.vignette()) },
                    .cancel()
                ])
            }
            // MARK: Challenge 1.3 -> Showing alert
            .alert(isPresented: $showingEmptyImage) { () -> Alert in
                Alert(title: Text("No Image Selected"), message: Text("Do select an image before proceeding"), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        // MARK: Challenge 2.3 -> name of the current filterTitle
        self.filterTitle = currentFilter.name
        applyProcessing()
    }
    
    func applyProcessing() {
//        currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        // MARK: Challenge 3.4 -> Using the values for radius and scale
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    // for setting the filters
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        // MARK: Challenge 2.4 -> name of the current filterTitle (if Changed)
//        let name = currentFilter.name
//        self.filterTitle = spiltTheString(name)
        self.filterTitle = currentFilter.name
        loadImage()
    }
    
//    func spiltTheString(_ name : String) -> String{
//        var output : String = ""
//
//        let start = name.startIndex
//        let letters : String.Index = name.index(start, offsetBy: 0)
//        let CILetter : String.Index = name.index(start, offsetBy: 2)
//
//        for _ in 0...10 {
//            output = String(name[CILetter..<letters])
//        }
//        return output
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
