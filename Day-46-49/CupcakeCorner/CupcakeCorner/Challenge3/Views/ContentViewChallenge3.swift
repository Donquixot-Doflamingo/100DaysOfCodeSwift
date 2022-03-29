//
//  ContentViewChallenge3.swift
//  CupcakeCorner
//
//  Created by harsh Khandelwal on 29/10/21.
//

import SwiftUI

struct ContentViewChallenge3: View {
    @ObservedObject var order = MyOrder()

    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.orderStruct.type) {
                        ForEach(0..<Order.types.count, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }

                    Stepper(value: $order.orderStruct.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.orderStruct.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.orderStruct.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }

                    if order.orderStruct.specialRequestEnabled {
                        Toggle(isOn: $order.orderStruct.extraFrosting) {
                            Text("Add extra frosting")
                        }

                        Toggle(isOn: $order.orderStruct.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AdressViewChallenge3(order: order)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentViewChallenge3_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewChallenge3()
    }
}
