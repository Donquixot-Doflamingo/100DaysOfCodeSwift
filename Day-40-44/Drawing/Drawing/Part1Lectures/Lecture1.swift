//
//  Lecture1.swift
//  Drawing
//
//  Created by harsh Khandelwal on 21/10/21.
//

import SwiftUI

struct Lecture1: View {
    var body: some View {
        // Lecture 1 of Drawing -> cutom
        VStack(spacing: 10) {
//               1. not having shjarp edes at top
//             CG-> core graphics
             Path { path in
                 path.move(to: CGPoint(x: 200, y: 100))
                 path.addLine(to: CGPoint(x: 100, y: 300))
                 path.addLine(to: CGPoint(x: 300, y: 300))
                 path.addLine(to: CGPoint(x: 200, y: 100))
             }
          .stroke(Color.red.opacity(0.25), lineWidth: 10)
            Spacer(minLength: 50)
//              2. have sharp edges at top by using an extra line
             Path { path in
                 path.move(to: CGPoint(x: 200, y: 100))
                 path.addLine(to: CGPoint(x: 100, y: 300))
                 path.addLine(to: CGPoint(x: 300, y: 300))
                 path.addLine(to: CGPoint(x: 200, y: 100))
                 path.addLine(to: CGPoint(x: 100, y: 300))
             }
             .stroke(Color.red, lineWidth: 10)
//              3. we have done thgis without using a extra line just by using StrokeStyle
             Path { path in
                 path.move(to: CGPoint(x: 200, y: 100))
                 path.addLine(to: CGPoint(x: 100, y: 300))
                 path.addLine(to: CGPoint(x: 300, y: 300))
                 path.addLine(to: CGPoint(x: 200, y: 100))
             }
             .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            
             Spacer(minLength: 50)
         }
//          Conclusion Wasn't able to solve the cutom cordinate problem we need something not point specific
//          --------------------------------------lecture 1 end ------------------------------//
    }
}

struct Lecture1_Previews: PreviewProvider {
    static var previews: some View {
        Lecture1()
    }
}
