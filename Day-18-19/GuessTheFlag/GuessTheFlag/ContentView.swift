//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by harsh Khandelwal on 27/09/21.
//

import SwiftUI
import CoreData

struct FlagImage : View{
    var imageFileName : String
    var body : some View{
        Image(imageFileName)
                    .renderingMode(.original)
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(Color.black, lineWidth: 2))
                    .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    
    
    @State private var SHowingAlert = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    
    @State private var correctAnswer = Int.random(in: (0...2))
    
    //challenge part -> animation
    @State private var animationAmount = 0
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    var body: some View {
        //Practise Session
//        ZStack {
//            Color(red: 0.8, green: 0.8, blue: 0.8).frame(width: 300, height: 300)
//            LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.black]), startPoint: .top, endPoint: .bottom)
//            RadialGradient(gradient: Gradient(colors: [Color.red, Color.blue]), center: .trailing, startRadius: 100, endRadius: 650)
//            AngularGradient(gradient: Gradient(colors: [Color.red, Color.blue, Color.yellow, Color.purple,Color.black]), center: .trailing)
//            VStack (spacing: 60.0){
//                HStack {
//                    Text("Hello world")
//                    Text("Hello world")
//                    Text("Hello world")
//                }
//                HStack(spacing: 10) {
//                    Text("Hello world")
//                    Text("Hello world")
//                    Text("Hello world")
//                }
//                HStack {
//                    Text("Hello world")
//                    Text("Hello world")
//                    Text("Hello world")
//                }
//                //a simple button
//                Button("Tap Me"){
//                    print("Button was tapped")
//                }
//                // complex funtionaly of button
//                Button(action: {
//                    print("Button was tapped")
//                }, label: {
//                    HStack(spacing: 10) {
//                        Image(systemName: "pencil").renderingMode(.original)
//                        Text("Edit").foregroundColor(.black)
//                    }.frame(width: 60, height: 60, alignment: .center)
//                })
//
//                // Alert Message
//                Button("Tap Me"){
//                    self.SHowingAlert = true
//                }
//                .alert(isPresented: $SHowingAlert){
//                    Alert(title: Text("Hello SwiftUI"), message: Text("This is a alert message"), dismissButton: .default(Text("OK")))
//                }
//            }
//        }
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack(spacing:30){
                    Text("Tap the Flag of").font(.title)
                    Text((countries[correctAnswer])).font(.largeTitle).fontWeight(.black)
                }.foregroundColor(.white)
                
                
                ForEach (0..<3){ number in
                    Button(action: {
                        // flagg tapped
                        withAnimation{
                                        if  self.flaggTapped(number) {
                                            self.animationAmount += 360
                                            
                                         }
                                      }
                    }) {
                        FlagImage(imageFileName :self.countries[number])
                            //Image(self.countries[number]).renderingMode(.original).clipShape(Capsule()).overlay(Capsule().stroke(Color.black, lineWidth: 1)).shadow(radius: 5).frame(width: 100, height: 100, alignment: .center)
                    }.rotation3DEffect(.degrees( (number == correctAnswer) ? Double(animationAmount) : 0.0), axis: (x: 0, y: 0, z: 1))
                }
//                    .rotation3DEffect(answer ? .degrees(360) : .degrees(0), axis: (x: 0.0, y: 1.0, z: 0.0))
                
                Text("Your current Score is -: \(userScore)").font(.system(size: 25, weight: .heavy, design: .rounded)).foregroundColor(.white)
                Spacer()
            }
        }.alert(isPresented: $showingScore){
            Alert(title: Text(scoreTitle), message: Text("Your Score is \(userScore)"), primaryButton: .default(Text("Continue")){
                self.askQuestion()
            },secondaryButton: .default(Text("Reset")){
                self.resetScore()
            })
        }
    }
    
    func flaggTapped(_ number : Int) -> Bool {
        if(number == correctAnswer){
            scoreTitle = "Correct"
            userScore += 1
            showingScore = true
            return true
        }
        else{
            scoreTitle = "Wrong! This is the flag of \(countries[number])"
            userScore += -1
            showingScore = true
            return false
        }
    }
    
    func askQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetScore(){
        userScore = 0
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

   

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
