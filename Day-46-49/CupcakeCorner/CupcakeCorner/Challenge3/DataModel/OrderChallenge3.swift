//
//  OrderChallenge3.swift
//  CupcakeCorner
//
//  Created by harsh Khandelwal on 29/10/21.
//

import Foundation

class MyOrder : ObservableObject{
    @Published var orderStruct = OrderStruct()
}

struct OrderStruct: Codable {
    
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

     var type = 0
     var quantity = 1

     var specialRequestEnabled = false{
        didSet {
               if specialRequestEnabled == false {
                   extraFrosting = false
                   addSprinkles = false
               }
           }
    }
     var extraFrosting = false
     var addSprinkles = false
     var name = ""
     var streetAddress = ""
     var city = ""
     var zip = ""
    
    var hasValidAddress: Bool {
        let name = self.name.trimmingCharacters(in: .whitespaces)
        let streetAddress = self.streetAddress.trimmingCharacters(in: .whitespaces)
        let city = self.city.trimmingCharacters(in: .whitespaces)
        let zip = self.zip.trimmingCharacters(in: .whitespaces)
        let zipLength = self.zip.count
        
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        if zipLength > 6 || zipLength < 6 {
            return false
        }

        return true
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        return cost
    }
    
}
