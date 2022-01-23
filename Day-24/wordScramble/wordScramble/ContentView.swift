//
//  ContentView.swift
//  wordScramble
//
//  Created by harsh Khandelwal on 03/10/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var userScore = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView{
            VStack{
                TextField("Enter your word", text: $newWord, onCommit: addNewWord).textFieldStyle(RoundedBorderTextFieldStyle()).autocapitalization(.none)
                    .padding()
                
                List(usedWords, id: \.self){
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                Text("Your Current Score is -: \(calculateScore())")
            }
            .navigationBarTitle(rootWord).onAppear(perform:startGame).navigationBarItems(trailing:
                    Button(action: startGame){
                        Text("Start New")
                    }
                )
            .alert(isPresented: $showingError){
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func calculateScore() -> Int{
        var score = 0
        for element in usedWords{
            score += element.count
        }
        return score
    }
    
    func addNewWord(){
        let answer = newWord.lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else{
            return
        }
        //extra validation to come
        guard original(word: answer) else {
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognised", message: "Don't make up words on your own")
            return
        }
        
        guard isReal(word: answer) else {
            return
        }
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame(){
        
        usedWords.removeAll()
        newWord = ""
//        calculateScore()
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try?
                String(contentsOf: startWordURL){
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkWorm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    
    // if the user repeats the same word
    func original(word: String) -> Bool {
        guard word != rootWord else{
            wordError(title: "Word is copy of the given word", message: "Don't copy the starting words of the given word")
            return false
        }
        guard !usedWords.contains(word) else{
            wordError(title: "Word already used", message: "Be more original")
            return false
        }
        return true
    }
    
    func isPossible(word: String) -> Bool{
        var tempWord = rootWord.lowercased()
        
        for letter in word{
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            } else{
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool{
        guard word.count > 3 else{
            wordError(title: "Word is shorter than 3 Words", message: "Make the word count more than 3")
            return false
        }

        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        guard misspelledRange.location == NSNotFound else{
            wordError(title: "Word is not possible", message: "That isn't a real word")
            return false
        }
        return true
}
    
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
