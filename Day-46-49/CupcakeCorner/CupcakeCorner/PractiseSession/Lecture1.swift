//
//  Lecture1.swift
//  CupcakeCorner
//
//  Created by harsh Khandelwal on 26/10/21.
//

import SwiftUI

/*
 However, if we make it @Published then the code no longer compiles:
 @Published var name = "Harsh"
 The @Published property wrapper isn’t magic – the name property wrapper comes from the fact that our name property is automatically wrapped inside another type that adds some additional functionality. In the case of @Published that’s a struct called Published that can store any kind of value.
 
 telling Swift which properties should be loaded and saved. This is done using an enum that conforms to a special protocol called CodingKey,
 which means that every case in our enum is the name of a property we want to load and save. This enum is conventionally called CodingKeys, with an S on the end, but you can call it something else if you want
 */
class User: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case name
    }
//    Finally, we can read values directly from that container by referencing cases in our enum – container.decode(String.self, forKey: .name). This provides really strong safety in two ways: we’re making it clear we expect to read a string, so if name gets changed to an integer the code will stop compiling; and we’re also using a case in our CodingKeys enum rather than a string, so there’s no chance of typos.
    
    @Published var name = "Harsh Khandelwal"
    
//    create a custom initializer that will be given some sort of container, and use that to read values for all our properties.
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        
        /*
         First, this initializer is handed an instance of a new type called Decoder. This contains all our data, but it’s down to us to figure out how to read it.

         Second, anyone who subclasses our User class must override this initializer with a custom implementation to make sure they add their own values. We mark this using the required keyword: required init. An alternative is to mark this class as final so that subclassing isn’t allowed, in which case we’d write final class User and drop the required keyword entirely.

         Third, inside the method we ask our Decoder instance for a container matching all the coding keys we already set in our CodingKey struct by writing decoder.container(keyedBy: CodingKeys.self). This means “this data should have a container where the keys match whatever cases we have in our CodingKeys enum. This is a throwing call, because it’s possible those keys don’t exist.
         */
    }
    
    //        This step is pretty much the reverse of the initializer we just wrote: we get handed an Encoder instance to write to, ask it to make a container using our CodingKeys enum for keys, then write our values attached to each key.
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
//    some real advantages here compared to the stringly typed API of UserDefaults – it’s much harder to make a mistake with Codable because we don’t use strings, and it automatically checks our data types are correct.
}
struct Lecture1: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct Lecture1_Previews: PreviewProvider {
    static var previews: some View {
        Lecture1()
    }
}
