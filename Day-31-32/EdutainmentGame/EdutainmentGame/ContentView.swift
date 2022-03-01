//
//  ContentView.swift
//  EdutainmentGame
//
//  Created by harsh Khandelwal on 09/10/21.
//

import SwiftUI
import CoreData

struct Questions {
    var text : String
    var answer : Int
}

struct AnswersImage: View {
    var image: String

    var body: some View{
        Image(image)
            .renderingMode(.original)
            .scaleEffect(0.5)
            .frame(width: 80, height: 80)
    }
}

struct AnswerButton : ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 300, height: 100, alignment: .center)
            .background(Color.gray)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
    }
}

extension View{
    func drawAnswerButton() -> some View{
        self.modifier(AnswerButton())
    }
}

struct GameLabel: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.yellow)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.green, lineWidth: 2))
            .padding(.bottom, 10)
            .padding(.top, 50)
    }
}

extension View{
    func drawGameLabel() -> some View{
        self.modifier(GameLabel())
    }
}

struct startToEndButton: ViewModifier{
    var whatColor : Bool

    func body(content: Content) -> some View {
        content
            .padding()
            .background(whatColor ? Color.purple : Color.green)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.green, lineWidth: 2))
            .font(.title)
            .padding(.top, 50)
            .foregroundColor(.black)

    }
}

extension View{
    func drawstartToEndButton(whatColor : Bool ) -> some View{
        self.modifier(startToEndButton(whatColor: whatColor))
    }
}

struct GamePicker : ViewModifier{
    func body(content: Content) -> some View {
        content
            .pickerStyle(SegmentedPickerStyle())
            .colorMultiply(.red)
            .padding(.bottom, 50)
    }
}

extension View{
    func drawGamePicker() -> some View{
        self.modifier(GamePicker())
    }
}

struct FontText: ViewModifier{
    let font = Font.system(size: 22, weight: .heavy, design: .default)

    func body(content: Content) -> some View {
        content
            .font(font)
    }
}

extension View{
    func setFontText() -> some View{
        self.modifier(FontText())
    }
}

struct DrawHorizontalText : View{
    var text : String
    var textresult : String

    var body: some View{
        HStack{
            Text(text)
                .modifier(FontText())
                .foregroundColor(Color.green)
            Text(textresult)
                .modifier(FontText())
                .foregroundColor(Color.red)
        }
        .padding(.top, 10)
    }
}

struct ContentView: View {

    @State private var ImageName = ["bear", "buffalo","chick","chicken","cow","crocodile","dog","duck","elephant","frog","giraffe","goat","gorilla","hippo","horse","monkey","moose","narwhal","owl","panda","parrot","penguin","pig","rabbit","rhino","sloth","snake","walrus","whale","zebra"]

    @State private var gameRunning = false
    @State private var multiplicationTable = 1
    let allMultiplication = Range(1...12)
    @State private var countOfQuestions = "5"
    let variantsOfQuestions = ["5","10","20","All"]

    @State private var arraysOfQuestions = [Questions]()

    @State private var currentQuestion = 0

    @State private var totalSscore = 0
    @State private var remainingQuestions = 0
    @State private var selectedNumber = 0

    @State private var isCorrect = false
    @State private var isWrong = false

    @State private var isShowingAlert = false
    @State private var alertTitle = ""
    @State private var buttonAlertTitle = ""

    @State private var isWinGame = false

    @State private var answerArray = [Questions]()

    let testArrayOfQuestion = [Questions(text: "1 * 1", answer: 1), Questions(text: "2 * 2", answer: 4), Questions(text: "3 * 3", answer: 9), Questions(text: "5 * 5", answer: 25)]

    var body: some View {
        Group {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.orange]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                if gameRunning{
                    VStack{
                        Text("\(arraysOfQuestions[currentQuestion].text)")
                            .drawGameLabel()
                            .font(.largeTitle)
                        VStack{
                            ForEach(0..<4, id: \.self){ number in
                                HStack{
                                    Button(action: {
                                        withAnimation{
                                            self.checkAnswer(number)
                                        }
                                    }) {
                                        AnswersImage (image: self.ImageName[number])
                                            .padding()

                                        Text("\(self.answerArray[number].answer)")
                                            .foregroundColor(Color.black)
                                            .font(.title)

                                    }
                                    .drawAnswerButton()
                                        .rotation3DEffect(.degrees(self.isCorrect && self.selectedNumber == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                                        .rotation3DEffect(.degrees(self.isWrong && self.selectedNumber == number ? 180 : 0), axis: (x: 0, y: 0, z: 0.5))
                                }
                            }
                        }
                        Button(action: {
                            gameRunning = false
                        }) {
                            Text("End Game")
                                .drawstartToEndButton(whatColor: gameRunning)
                        }

                        VStack{
                            DrawHorizontalText(text: "Total Score: ", textresult: "\(totalSscore)")
                            DrawHorizontalText(text: "Questions Remaining: ", textresult: "\(remainingQuestions)")
                        }
                        Spacer()
                        }
                    }
                else{
                    VStack{
                        // range of table
                        Text("Pick the range of table").drawGameLabel()
                        
                            Picker("", selection: $multiplicationTable){
                                ForEach(allMultiplication, id: \.self){
                                    Text("\($0)")
                                }
                            }.pickerStyle(SegmentedPickerStyle())

                        // number of questions
                        Text("Pick the number of questions").drawGameLabel()
                        
                            Picker("", selection: $countOfQuestions){
                                ForEach(variantsOfQuestions, id: \.self){
                                    Text("\($0)")
                                }
                            }.pickerStyle(SegmentedPickerStyle())


                        // game start button
                        Button(action: {
                            self.newGame()
                        }, label: {
                            Text("Start Game").drawstartToEndButton(whatColor: gameRunning)
                        })
                    }
                }

            }
        }.alert(isPresented: $isShowingAlert){ () -> Alert in
            Alert(title: Text(alertTitle), message: Text("your totle score is -: \(totalSscore)"), dismissButton: .default(Text("\(buttonAlertTitle)")){
                if self.isWinGame{
                    self.newGame()
                    self.isWinGame = false
                    self.isCorrect = false
                } else if self.isCorrect{
                    self.isCorrect = false
                    self.newQuestion()
                } else{
                    self.isWinGame = false
                }
            })

        }
    }
        func createArrayOfQuestions(){
            for i in 1 ... multiplicationTable{
                for j in 1...12{
                    let newQuestion = Questions(text: "How much is: \(i) * \(j) ?", answer: i * j)
                    arraysOfQuestions.append(newQuestion)
                }
            }
            self.arraysOfQuestions.shuffle()
            self.currentQuestion = 0
            self.answerArray = []
        }

        func setCountOfQuestions(){
            guard let count = Int(self.countOfQuestions) else {
                remainingQuestions = arraysOfQuestions.count
                return
            }
            remainingQuestions = count
        }

        func createAnswerArray(){
            if(currentQuestion + 4 < arraysOfQuestions.count){
                for i in currentQuestion ... currentQuestion + 3{
                    answerArray.append(arraysOfQuestions[i])
                }
            }
            else{
                for i in arraysOfQuestions.count - 4 ..< arraysOfQuestions.count{
                    answerArray.append(arraysOfQuestions[i])
                }
            }
            self.answerArray.shuffle()
        }

        func newGame(){
            self.gameRunning = true
            self.arraysOfQuestions = []
            self.createArrayOfQuestions()
            self.currentQuestion = 0
            self.setCountOfQuestions()
            self.answerArray = []
            self.createAnswerArray()
            self.ImageName.shuffle()
            self.totalSscore = 0
        }

        func newQuestion(){
            self.ImageName.shuffle()
            self.currentQuestion += 1
            self.answerArray = []
            self.createAnswerArray()
        }

        func checkAnswer( _ number : Int){
            self.selectedNumber = number
            if(answerArray[number].answer == arraysOfQuestions[currentQuestion].answer){
                self.isCorrect = true
                self.remainingQuestions -= 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    if (self.remainingQuestions == 0){
                        self.alertTitle = "You WON"
                        self.buttonAlertTitle = "Start a new game"
                        self.totalSscore += 1
                        self.isWinGame = true
                        self.isShowingAlert = true
                    } else{
                        self.alertTitle = "Correct!!"
                        self.buttonAlertTitle = "New Question"
                        self.totalSscore += 1
                        self.isShowingAlert = true
                    }
                }
            } else{
                isWrong = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self.alertTitle = "Wrong!!"
                    self.buttonAlertTitle = "Try Again"
                    self.totalSscore -= 1
                    self.isShowingAlert = true
                }
            }

        }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
