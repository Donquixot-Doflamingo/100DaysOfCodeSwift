//
//  ContentView.swift
//  iExpense
//
//  Created by harsh Khandelwal on 12/10/21.
//

import SwiftUI
import CoreData

struct ExpenseItem : Identifiable , Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem](){
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }

        self.items = []
    }
}

struct ContentView: View {
    
    @State private var showingAddExpense = false
    @ObservedObject var expenses = Expenses()
    
    var body: some View {
        
        NavigationView {
            List {
                //, id: \.id ->
                ForEach(expenses.items) { item in
                    HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font((item.amount < 10) ? .title3 : ((item.amount > 100) ? .largeTitle : .title2))
                                    .foregroundColor((item.amount < 10) ? .green : ((item.amount > 100) ? .red : Color.orange))
                                Text(item.type)
                            }

                            Spacer()
                        Text("$\(item.amount, specifier: "%g")")
                        }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(),  trailing:
                Button(action: {
                    self.showingAddExpense = true
                }) {
                        Image(systemName: "plus")
                    }
            )
            .sheet(isPresented: $showingAddExpense) {
                Addview(expenses: self.expenses)
        }
        }
        
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
