//
//  Lecture2.swift
//  Instafilter
//
//  Created by harsh Khandelwal on 20/11/21.
//

import SwiftUI

// ************************** MARK: Creating custom bindings in SwiftUI *************
struct Lecture2: View {
    
    @State private var blurAmount: CGFloat = 0
    
    var body: some View {
/*
         In our code, we want a Binding to return the value of blurAmount when it’s read, but when it’s written we want to change the value of blurAmount and also print that new value so we can see that it changed. Regardless of whether we’re reading or writing, we’re talking about something that reads our blurAmount property, and Swift doesn’t allow us to create properties that read other properties because the property we’re trying to read might not have been created yet.

         So, putting all that together we need to create a custom Binding struct that acts as a passthrough around blurAmount, but when we’re setting the value we also want to print a message. It’s also a requirement that we don’t store it as a property of our view, because reading one property from another isn’t allowed.
*/

        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
                },
            set: {
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
                }
            )

        return VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)

            //One thing that changed is the way we declare the binding in the slider: rather than using $blurAmount we can just use blur. This is because using the dollar sign is what gets us the two-way binding from some state, but now that we’ve created the binding directly we no longer need it.
            Slider(value: blur, in: 0...20)
        }
        
/* MARK: A Little look at Binding file
         the basic initializer for a Binding looks like this:
         MARK: init(get: @escaping () -> Value, set: @escaping (Value) -> Void) #Code
         1. Breaking that down, it’s telling us that the initializer takes two closures: a getter that takes no parameters and returns a value, and a setter that takes a value and returns nothing. Binding uses generics, so that Value is really a placeholder for whatever we’re storing inside – a CGFloat in the case of our blur binding. Both the get and set closures are marked as @escaping, meaning that the Binding struct stores them for use later on.
         2. What all this means is that you can do whatever you want inside these closures: you can call methods, run an algorithm to figure out the correct value to use, or even just use random values – it doesn’t matter, as long as you return a value from get. So, if you want to make sure you update UserDefaults every time a value is changed, the set closure of a Binding is perfect.
*/
    }
}

struct Lecture2_Previews: PreviewProvider {
    static var previews: some View {
        Lecture2()
    }
}
