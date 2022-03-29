//
//  Lecture4.swift
//  Drawing
//
//  Created by harsh Khandelwal on 21/10/21.
//

// ---------------------- Lecture 4 - Transforming shapes using CGAffineTransform and even-odd fills ----------

import SwiftUI

/*
 The first is CGAffineTransform, which describes how a path or view should be rotated, scaled, or sheared; and the second is even-odd fills, which allow us to control how overlapping shapes should be rendered.
  Points to be noted-:
  1. CGAffineTransform measures angles in radians rather than degrees.
 
 So, what we’re going to do is as follows:

 1. Create a new empty path.
 2. Count from 0 up to pi multiplied by 2 (360 degrees in radians), counting in one eighth of pi each time – this will give us 16 petals.
 3. Create a rotation transform equal to the current number.
 4. Add to that rotation a movement equal to half the width and height of our draw space, so each petal is centered in our shape.
 5. Create a new path for a petal, equal to an ellipse of a specific size.
 6. Apply our transform to that ellipse so it’s moved into position.
 7. Add that petal’s path to our main path.
 
 three more small things:

 1. Rotating something then moving it does not produce the same result as moving then rotating, because when you rotate it first the direction it moves will be different from if it were not rotated.
 2. To really help you understand what’s going on, we’ll be making our petal ellipses use a couple of properties we can pass in externally.
 3. Ranges such as 1...5 are great if you want to count through numbers one a time, but if you want to count in 2s, or in our case count in “pi/8”s, you should use stride(from:to:by:) instead.
 */

//CGAffineTransform can be used to store rotation and translation data.
//It can also store shearing and scaling.
struct Flower: Shape{
    
    var petalOffset : Double = -20
    var petalWidth : Double = 100
    
    func path(in rect: CGRect) -> Path{
        var path = Path()
        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8){
            let rotation = CGAffineTransform(rotationAngle: number)
            
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width/2, y: rect.height/2))
            
            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))
            
            let rotatedPetals = originalPetal.applying(position)
            
            path.addPath(rotatedPetals)
        }
        return path
    }
}

struct Lecture4: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    var body: some View {
        VStack {
            Flower(petalOffset : petalOffset, petalWidth : petalWidth)
//                    .stroke(Color.red, lineWidth: 1)
//                .fill(Color.red)
            /*
             we can fill the shape using the even-odd rule, which decides whether part of a path should be colored depending on the overlaps it contains. It works like this:

             1. If a path has no overlaps it will be filled.
             2. If another path overlaps it, the overlapping part won’t be filled.
             3. If a third path overlaps the previous two, then it will be filled.
             …and so on.
             */
                .fill(Color.red, style : FillStyle(eoFill: true) )

                Text("Offset")
                Slider(value: $petalOffset, in: -40...40)
                    .padding([.horizontal, .bottom])

                Text("Width")
                Slider(value: $petalWidth, in: 0...100)
                    .padding(.horizontal)
                }
    }
}

struct Lecture4_Previews: PreviewProvider {
    static var previews: some View {
        Lecture4()
    }
}
