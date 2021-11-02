//
//  ContentView.swift
//  WeSplit
//
//  Created by harsh Khandelwal on 24/09/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var checkAmount = ""
    // if using picker selection use the below one or else continue with numberOfPeoples
    //@State private var numberOfPeople = 2
    @State private var numberOfPeoples = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
  
    // to calculate the total amount with tip
    var totalAmount: Double{
        let tipSelection = Double(tipPercentages[tipPercentage])
        let order = Double(checkAmount) ?? 0 // if it fails or find letters it will give it 0
        let tip = (tipSelection * order)/100
        let grandAmount = order + tip
        return grandAmount
    }
    
    // to format the total amount like $0.00
    var formattedAmount: String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        let amount = totalAmount
        
        return formatter.string(from: NSNumber(value: amount)) ?? "0"
    }
    
    // to calculate the split amount
    var SplitAmount: Double{
        //if you are using picker turn this on or else use the one below it
        //let persons = Double(numberOfPeople + 2)
        let persons = Double(numberOfPeoples) ?? 0
        let split = totalAmount / persons
        return split
    }
    
    // to format the split in $0.00
    var formattedSplit: String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        let split = SplitAmount
        
        let returnString = formatter.string(from: NSNumber(value: split))
        
        if(returnString == "NaN" || returnString == "+∞"){
            return "\(totalAmount)"
        }
        
        return returnString ?? "0"
    }
    
    
    var body: some View {
        NavigationView{
            Form{
                // to get the amount
                Section(header: Text("Enter the amount you want to split")){
                    TextField("Type your amount here", text: $checkAmount).keyboardType(.decimalPad)
                }
                
                // to get the number of people
                Section(header: Text("number of people for split")){
                    TextField("Type your amount here", text: $numberOfPeoples).keyboardType(.numberPad)
                }
                /*to show the number people through picker
                 
                Section(header: Text("number of people for split")){
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2 ..< 100){
                            Text("\($0) people")
                        }
                    }
                }
                */
                
                // for amount of tip
                Section(header: Text("How much tip do you want to leave?")){
                    Picker("Percentage of tip", selection: $tipPercentage){
                        ForEach(0 ..< tipPercentages.count){
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }

                // to get the total amount with tip
                Section(header: Text("Total amount with tip")){
                    Text("\(formattedAmount)").multilineTextAlignment(.center).foregroundColor(tipPercentages[tipPercentage] == 0 ? .red : .black)
                }
                
                // amount per person
                Section(header: Text("Amount per person")){
                    Text("\(formattedSplit)").multilineTextAlignment(.center)
                }
            }
        }.navigationTitle("We Split")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
