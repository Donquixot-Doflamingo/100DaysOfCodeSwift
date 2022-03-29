//
//  AdressViewChallenge3.swift
//  CupcakeCorner
//
//  Created by harsh Khandelwal on 29/10/21.
//

import SwiftUI

struct AdressViewChallenge3: View {
    @ObservedObject var order = MyOrder()
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.orderStruct.name)
                TextField("Street Address", text: $order.orderStruct.streetAddress)
                
                TextField("City", text: $order.orderStruct.city)
                TextField("Zip", text: $order.orderStruct.zip)
                    .keyboardType(.phonePad)
            }

            Section {
                NavigationLink(destination: CheckOutViewChallenge3(order: order)) {
                    Text("Check out")
                }
            }
            .disabled(order.orderStruct.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AdressViewChallenge3_Previews: PreviewProvider {
    static var previews: some View {
        AdressViewChallenge3()
    }
}
