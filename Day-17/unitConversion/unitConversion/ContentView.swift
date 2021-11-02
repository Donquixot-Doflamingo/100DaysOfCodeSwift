//
//  ContentView.swift
//  unitConversion
//
//  Created by harsh Khandelwal on 26/09/21.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @State private var input = ""
    @State private var lengthOne = 2
    @State private var lengthTwo = 1
    
    let length = ["MM","CM","M","KM", "Mi"]
    
    var inputToMiliMeter : Double{
        var inMM : Double = 0
        let inputValue = Double(input) ?? 0
        if(lengthOne == 1){
            inMM = inputValue * 10
        }
        else if(lengthOne == 2){
            inMM = inputValue * 1000
        }
        else if(lengthOne == 3){
            inMM = inputValue * 1000000
        }
        else if(lengthOne == 4){
            inMM = inputValue * 1609000
        }
        else{
            inMM = inputValue
        }
        return inMM
    }
    
    var MMtoLength : Double{
        var result : Double = 0
        let lengthInMM = inputToMiliMeter
        
        if(lengthTwo == 1){
            result = lengthInMM * 0.1
        }
        else if(lengthTwo == 2){
            result = lengthInMM * 0.001
        }
        else if(lengthTwo == 3){
            result = lengthInMM * 1e-6
        }
        else if(lengthTwo == 4){
            result = lengthInMM * 6.2137e-7
        }
        else{
            result = lengthInMM
        }
        return result
    }
    

    
    var body: some View {
       NavigationView{
            Form{
                Section(header: Text("Enter the length you want to convert")){
                    TextField("Length", text: $input).keyboardType(.decimalPad)
                }
                Section(header: Text("Select the current length")){
                    Picker("Length", selection: $lengthOne){
                        ForEach(0 ..< length.count) {
                            Text("\(self.length[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("length you want to convert into")){
                    Picker("Length", selection: $lengthTwo){
                        ForEach(0 ..< length.count) {
                            Text("\(self.length[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Result")){
                    Text("\(MMtoLength, specifier: "%.2f")  \(length[lengthTwo])" )
                }
            }.navigationTitle("Length Converter")
       }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
