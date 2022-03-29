//
//  ChallengeDay.swift
//  Drawing
//
//  Created by harsh Khandelwal on 23/10/21.
//

import SwiftUI

struct ArrowHead: Shape{
//    Make the line thickness of your Arrow shape animatable.
    var thickness: CGFloat

    var animatableData: CGFloat {
        get { thickness }
        set { self.thickness = newValue }
    }
    // 1. Create an Arrow shape made from a rectangle and a triangle – having it point straight up is fine.
    func path(in rect: CGRect) -> Path {
            Path { path in
                let width = rect.width
                let height = rect.height
                
                // 2.
                path.addLines( [
                    CGPoint(x: width * 0.4, y: height),
                    CGPoint(x: width * 0.4, y: height * 0.4),
                    CGPoint(x: width * 0.2, y: height * 0.4),
                    CGPoint(x: width * 0.5, y: height * 0.1),
                    CGPoint(x: width * 0.8, y: height * 0.4),
                    CGPoint(x: width * 0.6, y: height * 0.4),
                    CGPoint(x: width * 0.6, y: height)
                ])
                // 3.
                path.closeSubpath()
            }
        }
}

// 3. Create a ColorCyclingRectangle shape that is the rectangular cousin of ColorCyclingCircle, allowing us to control the position of the gradient using a property.
struct ColorCyclingRectangle : View{
    var amount = 0.0
    var steps = 100
    
    var body: some View{
        ZStack{
            ForEach(0..<steps){ value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [self.color(for: value, brightness: 1), self.color(for: value, brightness: 0.5)]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }.drawingGroup()
    }
    
    func color(for value : Int, brightness : Double) -> Color{
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if targetHue > 1{
            targetHue -= 1;
        }
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ChallengeDay: View {
    @State private var thickness: CGFloat = 10
    @State private var colorCycle = 0.0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ArrowHead(thickness: thickness)
                    .stroke(Color.red, style: StrokeStyle(lineWidth: thickness, lineCap: .round, lineJoin: .round))
                    .frame(width: 200, height: 350, alignment: .center)
                    .onTapGesture {
                        withAnimation{
                            self.thickness = CGFloat.random(in: 10...30)
                        }
                    }
                    .padding(.bottom, 50)

                ColorCyclingRectangle(amount: self.colorCycle)
                    .frame(width: 200, height: 350, alignment: .center)
                    .padding(.bottom, 20)
                
                Text("Color Cycle: \(colorCycle, specifier: "%.2f")")
                Slider(value: $colorCycle, in: 0.01...1, step: 0.01)
                    .padding([.horizontal, .bottom])
            }
        }
    }
}

struct ChallengeDay_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeDay()
    }
}
