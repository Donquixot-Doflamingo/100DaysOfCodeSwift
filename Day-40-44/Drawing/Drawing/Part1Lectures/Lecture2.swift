//
//  Lecture2.swift
//  Drawing
//
//  Created by harsh Khandelwal on 21/10/21.
//

import SwiftUI

//----------------------- Lecture 2--------------
struct Triangle: Shape{
    func path(in rect: CGRect) -> Path{
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

struct arc: Shape{
    var startAngle: Angle
    var endAngle: Angle
    var clockWise: Bool
    // make a new var of insetAmount for lecture 3
//    var insetAmount: CGFloat = 0
    func path(in rect: CGRect) -> Path{
        let rotationAdjestments = Angle.degrees(90)
        let modiefiedStart = startAngle - rotationAdjestments
        let modiefiedEnd = endAngle - rotationAdjestments
        var path = Path()
        // 3. subtract the inset amount in the radius for lecture 3
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width/2 , startAngle: modiefiedStart, endAngle: modiefiedEnd, clockwise: !clockWise)
        return path
    }
    // 2. make a new inset funtion to make it conforms to it for lecture 3
//    func inset(by amount: CGFloat) -> some InsettableShape{
//        var Arc = self
//        Arc.insetAmount += amount
//        return Arc
//    }
}

// ------------------------- End of Lecture 2--------------------
struct Lecture2: View {
    var body: some View {
        //Lecture 2 -> Paths vs shapes
                VStack(spacing: 100) {
                    Triangle()
                         .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .frame(width: 300, height: 300, alignment: .trailing)
                    arc(startAngle: .degrees(0), endAngle: .degrees(360), clockWise: true)
                        .stroke(Color.blue, lineWidth: 10)
                        .frame(width: 200, height: 200)
                }
                // -----------------Lecture 2 ends------------------
    }
}

struct Lecture2_Previews: PreviewProvider {
    static var previews: some View {
        Lecture2()
    }
}
