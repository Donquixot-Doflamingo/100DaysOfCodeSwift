//
//  Order.swift
//  CupcakeCorner
//
//  Created by harsh Khandelwal on 28/10/21.
//

import Foundation

class Order: ObservableObject, Codable {
    
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    @Published var type = 0
    @Published var quantity = 1

    @Published var specialRequestEnabled = false{
        didSet {
               if specialRequestEnabled == false {
                   extraFrosting = false
                   addSprinkles = false
               }
           }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    // for Address View
    
    /*
     Go ahead and run the app again, because I want you to see why all this matters. Enter some data on the first screen, enter some data on the second screen, then try navigating back to the beginning then forward to the end – that is, go back to the first screen, then click the bottom button twice to get to the checkout view again.

     What you should see is that all the data you entered stays saved no matter what screen you’re on. Yes, this is the natural side effect of using a class for our data, but it’s an instant feature in our app without having to do any work – if we had used a struct, then any address details we had entered would disappear if we moved back to the original view. If you really wanted to use a struct for your data, you should follow the same struct inside class approach we used back in project 7; it’s certainly worth keeping it in mind when you evaluate your options.
     */
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
//    So, instead we’re just going to check that the name, streetAddress, city, and zip properties of our order aren’t empty.
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
    
    init() { }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)

        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)

        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)

        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)

        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
}
