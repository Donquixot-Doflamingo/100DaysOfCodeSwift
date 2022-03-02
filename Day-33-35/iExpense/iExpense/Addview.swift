//
//  Addview.swift
//  iExpense
//
//  Created by harsh Khandelwal on 15/10/21.
//

import SwiftUI

struct Addview: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @ObservedObject var expenses: Expenses
    
    @State var isShowingAlert = false
    @State var alertTitle = ""
    @State var alertMessage = ""
    
        static let types = ["Business", "Personal"]

        var body: some View {
            NavigationView {
                Form {
                    TextField("Name", text: $name)
                    Picker("Type", selection: $type) {
                        ForEach(Self.types, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    TextField("Amount", text: $amount)
                        .keyboardType(.numberPad)
                }
                .navigationBarTitle("Add new expense")
                .navigationBarItems(trailing: Button("Save") {
//                    if let actualAmount = Int(self.amount) {
//                        let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
//                        self.expenses.items.append(item)
//                        self.presentationMode.wrappedValue.dismiss()
//                    }
                    guard let actualAmount = Double(self.amount) else{
                        isShowingAlert = true
                        alertTitle = "Wrong amount input"
                        alertMessage = "Amount input should be a number. Dummy!!"
                        return
                    }
                    isShowingAlert = false
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                })
                .alert(isPresented: $isShowingAlert){
                    Alert(title: Text("\(alertTitle)"), message: Text("\(alertMessage)"), dismissButton: .default(Text("Try Again")))
                }
            }
        }
}

struct Addview_Previews: PreviewProvider {
    static var previews: some View {
        Addview(expenses: Expenses())
    }
}
