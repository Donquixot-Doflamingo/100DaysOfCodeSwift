//
//  Lesson1.swift
//  Instafilter
//
//  Created by harsh Khandelwal on 19/11/21.
//

import SwiftUI
// ***********************MARK: How property wrappers become structs*****************
struct Lesson1: View {
    /*MARK: How state is working
     To visit State code ,(Cmd+Shift+O and search State)
     We asked to see State, so you should have been taken to this line:
     MARK: @propertyWrapper public struct State<Value> : DynamicProperty { #CODE
     That @propertyWrapper attribute is what makes this into @State for us to use.
     Now look a few lines further down, and you should see this:
        MARK: public var wrappedValue: Value { get nonmutating set } #CODE
     That wrapped value is the actual value we’re trying to store, such as a string. What this generated interface is telling us is that the property can be read (get), and written (set), but that when we set the value it won’t actually change the struct itself. Behind the scenes, it sends that value off to SwiftUI for storage in a place where it can be modified freely, so it’s true that the struct itself never changes.
     */
    @State private var blurAmount : CGFloat = 0{
        didSet {
                print("New value is \(blurAmount)")
            }
        // this code is expected to print the value of blurAmount everytime its being changed
    }
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)

            Slider(value: $blurAmount, in: 00...20)
        }
/*
        MARK: Reson why it is not  morking
    On the surface, that states “when blurAmount changes, print out its new value.” However, because @State actually wraps its contents, what it’s actually saying is that when the State struct that wraps blurAmount changes, print out the new blur amount.

    Still with me? Now let’s go a stage further: you’ve just seen how State wraps its value using a non-mutating setter, which means neither blurAmount or the State struct wrapping it are changing – our binding is directly changing the internally stored value, which means the property observer is never being triggered.
*/
    }
}

struct Lesson1_Previews: PreviewProvider {
    static var previews: some View {
        Lesson1()
    }
}
