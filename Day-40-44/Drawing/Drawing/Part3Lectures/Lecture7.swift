//
//  Lecture7.swift
//  Drawing
//
//  Created by harsh Khandelwal on 22/10/21.
//

import SwiftUI

struct Lecture7: View {
    
    @State private var amount: CGFloat = 0.0
    
    var body: some View {
//  Blend modes allow us to control the way one view is rendered on top of another. The default mode is .normal, which just draws the pixels from the new view onto whatever is behind, but there are lots of options for controlling color and opacity.
        ScrollView {
            VStack {
                Spacer(minLength: 90)
                ZStack {
                    
                    Circle()
    //                    .fill(Color.red)
                        .fill(Color(red: 1, green: 0, blue: 0))
                        .frame(width: 200 * amount)
                        .offset(x: -50, y: -80)
                        .blendMode(.screen)
                    /*
    If you’re particularly observant, you might notice that the fully blended color in the center isn’t quite
    white – it’s a very pale lilac color. The reason for this is that Color.red, Color.green, and Color.blue
    aren’t fully those colors; you’re not seeing pure red when you use Color.red. Instead, you’re seeing SwiftUI’s
    adaptive colors that are designed to look good in both dark mode and light mode, so they are a custom blend of
    red, green, and blue rather than pure shades.
    */

                    Circle()
    //                    .fill(Color.green)
                        .fill(Color(red: 0, green: 1, blue: 0))
                        .frame(width: 200 * amount)
                        .offset(x: 50, y: -80)
                        .blendMode(.screen)

                    Circle()
                        .fill(Color(red: 0, green: 0, blue: 1))
    //                    .fill(Color.blue)
                        .frame(width: 200 * amount)
                        .blendMode(.screen)
    //                Image("Example")
    //
    //                Rectangle()
    //                    .fill(Color.red)
    //                    .blendMode(.multiply)
                    /*
                     “Multiply” is so named because it multiplies each source pixel color with the destination pixel
                     color – in our case, each pixel of the image and each pixel of the rectangle on top. Each pixel
                     has color values for RGBA, ranging from 0 (none of that color) through to 1 (all of that color),
                     so the highest resulting color will be 1x1, and the lowest will be 0x0.

                     Using multiply with a solid color applies a really common tint effect: blacks stay black (because
                     they have the color value of 0, so regardless of what you put on top multiplying by 0 will
                     produce 0), whereas lighter colors become various shades of the tint.
                     */
                }
                .frame(width: 300, height: 400)
            .clipped()
            }
            
            Slider(value: $amount)
                .padding()
            
            Image("Example")
                .resizable()
                .colorMultiply(.red)
                .scaledToFit()
                .frame(width: 300, height: 300)
//            saturation(), which adjusts how much color is used inside a view. Give this a value between 0 (no color, just grayscale) and 1 (full color).
                .saturation(Double(amount))
                .blur(radius: (1 - amount) * 20)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        // shortcut of doing the above thing
    }
}

struct Lecture7_Previews: PreviewProvider {
    static var previews: some View {
        Lecture7()
    }
}
