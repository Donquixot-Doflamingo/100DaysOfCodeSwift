//
//  ContentView.swift
//  Drawing
//
//  Created by harsh Khandelwal on 19/10/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
    
    // Lecture 4 -> Transforming shapes using CGAffineTransform
        NavigationView {
            VStack{
                List{
                    Section(header: Text("Day 1")) {
                        NavigationLink(destination:  Lecture1()){
                            Text("Basic of drawing")
                        }
                        
                        NavigationLink(destination: Lecture2()){
                            Text("Path in struct using shaped")
                        }
                        
                        NavigationLink(destination:  Lecture3()){
                            Text("InsettableShape")
                        }
                    }
                    
                    Section(header: Text("Day 2")) {
                        NavigationLink(destination:  Lecture4()){
                            Text("CGAffineTransform feature")
                        }
                     
                        NavigationLink(destination:  Lecture5()){
                            Text("ImagePaint for images")
                        }
                        
                        NavigationLink(destination:  Lecture6()){
                            Text("drawingGroup() use")
                        }
                    }
                    
                    Section(header: Text("Day 3")) {
                        NavigationLink(destination:  Lecture7()){
                            Text("BlendMode, Blur and Saturation")
                        }
                     
                        NavigationLink(destination:  Lecture8()){
                            Text("AnimatableData use")
                        }
                        
                        NavigationLink(destination:  Lecture9()){
                            Text("animatableData: AnimatablePair<Double, Double>")
                        }
                        
                        NavigationLink(destination:  Lecture10()){
                            Text("Simple Spirograph")
                        }
                    }
                    
                    Section(header: Text("Final Challenge")) {
                        NavigationLink(destination:  ChallengeDay()){
                            Text("Drawing Wrap up")
                        }
                    }
                }
                Spacer()
            }
            .navigationBarTitle("Drawing in SwiftUI")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
