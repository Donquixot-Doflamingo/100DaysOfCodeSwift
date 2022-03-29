//
//  Lecture3.swift
//  Drawing
//
//  Created by harsh Khandelwal on 21/10/21.
//

import SwiftUI


struct ARC: InsettableShape{
    var startAngle: Angle
    var endAngle: Angle
    var clockWise: Bool
    // make a new var of insetAmount for lecture 3
    var insetAmount: CGFloat = 0
    func path(in rect: CGRect) -> Path{
        let rotationAdjestments = Angle.degrees(90)
        let modiefiedStart = startAngle - rotationAdjestments
        let modiefiedEnd = endAngle - rotationAdjestments
        var path = Path()
        // 3. subtract the inset amount in the radius for lecture 3
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width/2 - insetAmount, startAngle: modiefiedStart, endAngle: modiefiedEnd, clockwise: !clockWise)
        return path
    }
    // 2. make a new inset funtion to make it conforms to it for lecture 3
    func inset(by amount: CGFloat) -> some InsettableShape{
        var Arc = self
        Arc.insetAmount += amount
        return Arc
    }
}

struct Lecture3: View {
    var body: some View {
//         lecture 3 -> Adding strokeBorder() support with InsettableShape
        VStack(spacing: 10) {
//             without strokeborder
            Circle()
                .stroke(Color.blue, lineWidth: 40)
//             with strokeborder
            Circle()
                .strokeBorder(Color.blue, lineWidth: 40)
//             if we try to apply strokeBorder toi arc it won't weork because arc doens't has a protocol of insettable to make it conform to it do the following 1, 2, 3, 4
            ARC(startAngle: .degrees(-90), endAngle: .degrees(90), clockWise: true)
                .strokeBorder(Color.blue, lineWidth: 40)
        }
        // --------------------------Lecture 3 ends-----------------------------    }
    }
}

struct Lecture3_Previews: PreviewProvider {
    static var previews: some View {
        Lecture3()
    }
}
