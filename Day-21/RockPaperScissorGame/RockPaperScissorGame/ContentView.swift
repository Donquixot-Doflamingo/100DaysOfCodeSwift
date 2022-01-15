//
//  ContentView.swift
//  RockPaperScissorGame
//
//  Created by harsh Khandelwal on 30/09/21.
//
/*
 Rock Paper Scissor Game (Tricky version)
 Day 21
 Made a Rock Paper Scissor Game
 - used View Modifier to design my buttons
 - Used random array for vale and for the result require to win
 - alert for new game or try again
 - Counting and displaying score at the end of the game
 */
import SwiftUI
import CoreData

// button design
struct ButtonDesign: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 80, height: 60, alignment: .center)
            .foregroundColor(.black)
            .background(Color.red)
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .cornerRadius(15)
    }
}

extension View {
    func buttonDesign() -> some View {
        modifier(ButtonDesign())
    }
}

struct ContentView: View {
    
    var things = ["Rock", "Paper", "Scissor"]
    @State private var shouldWin = false
    @State private var choice = "Paper"
    @State private var score = 0
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var roundCount = 0
    @State private var roundCountView = false
    
    func nextRound() {
            choice = things[Int.random(in: 0...2)]
            shouldWin = Bool.random()
            roundCount += 1
            if roundCount < 11 {
                roundCountView = false
            } else {
                roundCountView = true
                roundCount = 0
            }
        }

    
    // game logic when Rock is selected
    func rockWasSelected() {
        if choice == things[2] && shouldWin || choice == things[1] && !shouldWin {
            score += 1
            alertTitle = "You Won :)"
        } else if choice == things[0] && shouldWin || choice == things[0] && !shouldWin {
            score += 0
            alertTitle = "We're equal :/"
        } else {
            score -= 1
            alertTitle = "You lost :("
        }
        showingAlert = true
    }

    // game logic when Paper is selected
    func paperWasSelected() {
        if choice == things[0] && shouldWin || choice == things[2] && !shouldWin {
            score += 1
            alertTitle = "You Won :)"
        } else if choice == things[1] && shouldWin || choice == things[1] && !shouldWin {
            score += 0
            alertTitle = "We're equal :/"
        } else {
            score -= 1
            alertTitle = "You lost :("
        }
        showingAlert = true
    }

    // game logic when Scissors is selected
    func scissorsWasSelected() {
        if choice == things[1] && shouldWin || choice == things[0] && !shouldWin {
            score += 1
            alertTitle = "You Won :)"
        } else if choice == things[2] && shouldWin || choice == things[2] && !shouldWin {
            score += 0
            alertTitle = "We're equal :/"
        } else {
            score -= 1
            alertTitle = "You lost :("
        }
        showingAlert = true
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.orange, Color(.yellow)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)

            VStack {
                VStack(spacing: 20) {
                    Text("Next round you must").font(.title)
                    Text(shouldWin ? "Win".uppercased() : "Loose".uppercased())
                                .font(.largeTitle)
                                .fontWeight(.bold)
                }
                .foregroundColor(.black)

                Spacer()
                // Rock selection button
                HStack(spacing: 20) {
                    Button(action: {
                        rockWasSelected()
                    }) {
                            Text("\(things[0])")
                                    .buttonDesign()
                        }
                    // Paper selection
                    Button(action: {
                        paperWasSelected()
                    }) {
                            Text("\(things[1])")
                                    .buttonDesign()
                        }
                    // Scissors selection
                    Button(action: {
                        scissorsWasSelected()
                    }) {
                            Text("\(things[2])")
                                    .buttonDesign()
                        }
                }
                Spacer()

                Text(roundCountView ? "Score \(score)" : "")
                            .font(.title)
                            .foregroundColor(.black)
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(roundCountView ? "GAME OVER!" : alertTitle), message: Text("Game picked \(choice)"), dismissButton: .default(Text(roundCountView ? "Click for next game" : "Next round")){
                    nextRound()
                })
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
