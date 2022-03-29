//
//  Lecture5.swift
//  Drawing
//
//  Created by harsh Khandelwal on 22/10/21.
//

//------------------- Lecture 5 - Creative borders and fills using ImagePaint -----------------

import SwiftUI

struct Lecture5: View {
    var body: some View {
        /*
         The type is called ImagePaint, and it’s created using one to three parameters. At the very least you
         need to give it an Image to work with as its first parameter, but you can also provide a rectangle
         within that image to use as the source of your drawing specified in the range of 0 to 1 (the second
         parameter), and a scale for that image (the third parameter). Those second and third parameters have
         sensible default values of “the whole image” and “100% scale”, so you can sometimes ignore them.
         */
        VStack {
            Text("Hello World")
                .frame(width: 100, height: 100)
            .background(Color.red)
            Text("Hello World")
                .frame(width: 150, height: 100)
                .border(Color.red, width: 10)
            Text("Hello World")
                .frame(width: 200, height: 100)
                .border(ImagePaint(image: Image("Example"), scale: 0.2), width: 30)
//            If you want to try using the sourceRect parameter, make sure you pass in a CGRect of relative sizes and positions: 0 means “start” and 1 means “end”.
            Text("Hello World")
                .frame(width: 200, height: 100)
                .border(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.1), width: 30)
//            It’s worth adding that ImagePaint can be used for view backgrounds and also shape strokes.
            Capsule()
                .strokeBorder(ImagePaint(image: Image("Example"), scale: 0.1), lineWidth: 20)
                .frame(width: 200, height: 100)
//  Conclusion-: ImagePaint will automatically keep tiling its image until it has filled its area – it can work with backgrounds, strokes, borders, and fills of any size.
        }
        
        // wrong way of doing it
//        Text("Hello World")
//            .frame(width: 150, height: 100)
//            .background(Image("Example"))
//        // or
//        Text("Hello World")
//            .frame(width: 150, height: 100)
//            .background(Image("Example"), width: 30)
    }
}

struct Lecture5_Previews: PreviewProvider {
    static var previews: some View {
        Lecture5()
    }
}
