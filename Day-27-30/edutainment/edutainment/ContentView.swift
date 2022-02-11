//
//  ContentView.swift
//  edutainment
//
//  Created by harsh Khandelwal on 06/10/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var TableOf : Int = 2
    @State private var numberOfQuestions = ["5","10","15","20", "30"]
    @State private var selectedChoice = 2
    @State private var settingOn : Bool = false
    @State private var questionsCount = 0
    
    @State private var lastQuestionReached = false
    
    @State private var isSubmitPressed = false
    @State private var isQuestionLimit = false
    
    @State private var randomMultiplier : Int = Int.random(in: (2...10))
    @State private var userMultiplier : Int = 2
    @State private var userAnswer = ""
    @State private var isCorrect = false
    @State private var score = 0
    
    func randomGenerator(){
        userMultiplier = Int.random(in: (2...TableOf))
    }
    
    func nextQuestion(){
        randomMultiplier = Int.random(in: (2...10))
        randomGenerator()
    }
    
    func calculate(){
        
        questionsCount += 1
        print("question copunt  \(questionsCount)")
        if(questionsCount == Int(numberOfQuestions[selectedChoice])){
            isQuestionLimit = true
        }
        
        guard let UserAnswer = Int(userAnswer) else{
            print("wrong input")
            return
        }
        
        let value = randomMultiplier * userMultiplier
        
        if(value == UserAnswer){
            isCorrect = true
            self.score = self.score + 1
        }
        else if(value > UserAnswer || value < UserAnswer){
            isCorrect = false
            self.score = self.score - 1
        }
        userAnswer = ""
        isSubmitPressed = true
        
        nextQuestion()
        randomGenerator()
    }
    
    func reset(){
        settingOn = true
        isCorrect = false
        isQuestionLimit = false
        score = 0
        nextQuestion()
        questionsCount = 0
    }
    
    var body: some View {
        NavigationView {
                Form {
                    // Stepper taking the range of values with condition of visibility
                    if(settingOn == true){
                        Section(header: Text("Enter the following values")){
                            // taking the range of value
                            Stepper(value: $TableOf, in: 2...12, step: 1){
                                Text("Range of Table -> \(TableOf)")
                            }
                            // select the number of questions
                            Picker("Number of questions", selection: $selectedChoice){
                                ForEach(0..<numberOfQuestions.count){
                                    Text("\(numberOfQuestions[$0])")
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                        }.animation(.spring())
                    }
                        
                    // Text which will provide the question to the user
                    Section(header: Text("Question is here")){
                        if(!isQuestionLimit){
                            Text("Question is -: \(userMultiplier) * \(randomMultiplier) = ??")
                        }
                        else{
                            Text("Your final score is-: \(score)/\(numberOfQuestions[selectedChoice]) ! Reset to play again")
                        }
                        
                    }
                    
                    if(!isQuestionLimit){
                        // so that user is able to give his answer
                        Section(header: Text("Type your answer")){
                            TextField("Type your amount here", text: $userAnswer, onCommit: calculate).keyboardType(.decimalPad).frame(width: 1000, alignment: .center)
                        }
                    
                        // to display is answer is wrong or right
                        if(isSubmitPressed){
                            Section(header: Text("To display the result")){
                                Text("\(isCorrect ? "Right" : "Wrong") Answer")
                            }
                        }
                    
                        // showing the score of the user
                        Section{
                            Text("Your current score is -: \(self.score)")
                        }
                    }
                    
                }
                .navigationTitle("EDUTAINMENT")
                .navigationBarItems(leading:
                                Button(action: {
                                        reset()
                                        isSubmitPressed = false
                                    },
                                        label: {
                                            Text("Reset Game").font(.headline)
                                        }
                                )
                                .foregroundColor(.black).background(Color.red),
                            trailing:
                                Button(action: {
                                        self.settingOn.toggle()
                                },
                                    label: {
                                        Text("Set range").font(.headline)
                                    }
                                )
                                .foregroundColor(.black).background(Color.red)
                        )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
