//
//  Lecture2.swift
//  Bookworm
//
//  Created by harsh Khandelwal on 29/10/21.
//

import SwiftUI

struct Lecture2: View {
    
//    @Environment(\.presentationMode) var presentationMode
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        
//        VStack {
//            Text("Hello, World!")
//                .onTapGesture {
//                self.presentationMode.wrappedValue.dismiss()
//            }
            
            if sizeClass == .compact {
                return AnyView(VStack{
                /*
                AnyView conforms to the same View protocol as Text, Color, VStack, and more, and it also contains inside it a view of a specific type. However, externally AnyView doesn’t expose what it contains – Swift sees our condition as returning either an AnyView or an AnyView, so it’s considered the same type. This is where the name “type erasure” comes from: AnyView effectively hides – or erases – the type of the views it contains.
                 logical conclusion here is to ask why we don’t use AnyView all the time if it lets us avoid the restrictions of some View. The answer is simple: performance. When SwiftUI knows exactly what’s in our view hierarchy, it can add and remove small parts trivially as needed, but when we use AnyView we’re actively denying SwiftUI that information. As a result, it’s likely to have to do significantly more work to keep our user interface updated when regular changes happen, so it’s generally best to avoid AnyView unless you specifically need it.
                */
                    Text("Active size class:")
                    Text("COMPACT")
                }
                .font(.largeTitle))
            }
            else {
               return AnyView(HStack {
                    Text("Active size class:")
                    Text("REGULAR")
                }
                .font(.largeTitle))
            }
//        }
    }
}

struct Lecture2_Previews: PreviewProvider {
    static var previews: some View {
        Lecture2()
    }
}
