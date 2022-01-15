//
//  ContentView.swift
//  BetterRest
//
//  Created by harsh Khandelwal on 02/10/21.
//

/*
 BetterRest sleep calculator app
 
 BetterRest sleep calculator app uses ML and suggesting you best sleep time by taking you no of coffee, no of hours you want to sleep and and when do you wanna wake up.
 
 Day 22
 - learnt about how to make ML in apple developer tool
 - Collected the data for the ML
 - Started the learning
 - made the basic look of the app
 
 Day - 23
 - Made a simple calculator for the output
 - Used alerts to display output
 - Used the ML Model and tested it.
 - Changed the look and used Form for UI
 - Used and learnt the Date Components in SwiftUI.
 */

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
//    @State private var alertTitle = ""
//    @State private var alertMessage = ""
//    @State private var showingAlert = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you wanna wake up")){
                    // for wake up time
                    //Text("").font(.headline)
                
                    DatePicker("Please pick a date", selection: $wakeUp, displayedComponents : .hourAndMinute).labelsHidden()
                }
                
                Section(header: Text("Desired amount of sleep")){
                    //sleep amount
                    //Text("Desired amount of sleep").font(.headline)
                
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25){
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                
                Section(header: Text("Daily coffee intake")){
                    // coffee intake
//                    Text("Daily coffee intake").font(.headline)
                
                    Picker("Number of cups", selection: $coffeeAmount){
                        ForEach(1 ..< 21){numbers in
                            if(numbers == 1){
                                Text("\(numbers) cup")
                            }
                            else{
                                Text("\(numbers) cups")
                            }
                        }
                    }
                    
//                    Stepper(value: $coffeeAmount, in: 1...20){
//                        if(coffeeAmount == 1){
//                            Text("1 cup")
//                        }
//                        else{
//                            Text("\(coffeeAmount) cups")
//                        }
//                    }
                
               }
                
                Section(header: Text("Recommended bed Time")){
                    Text("\(calculateBedTime())")
                }
                
            }.navigationBarTitle("Better Rest")
//            .navigationBarItems(trailing:
//                Button(action: calculateBedTime){
//                    Text("Calculate")
//                }
//            )
//            .alert(isPresented: $showingAlert){
//                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    
    static var defaultWakeTime : Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    func calculateBedTime()-> String{
        
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minutes = (components.minute ?? 0) * 60
        
        do {
            let prediction = try
                model.prediction(wake: Double(hour + minutes), estimatedSleep: sleepAmount, coffee : Double(coffeeAmount))
            
            let formatter =  DateFormatter()
            formatter.timeStyle = .short
            
            let sleepTime = wakeUp - prediction.actualSleep
            
//            alertMessage = formatter.string(from: sleepTime)
//            alertTitle = "Your ideal bed time is -: "
            return formatter.string(from: sleepTime)
        }
        catch  {
//            alertTitle = "Error"
//            alertMessage = "Sorry, there was a problem calculating your BedTime."
            return "Error !!Sorry, there was a problem calculating your BedTime."
        }
//        showingAlert = true
    }
}

   

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
