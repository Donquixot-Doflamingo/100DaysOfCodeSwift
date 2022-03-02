//
//  ContentView.swift
//  moonShot
//
//  Created by harsh Khandelwal on 15/10/21.
//

import SwiftUI
import CoreData

struct ContentView: View {

    let astronauts : [Astronaut] = Bundle.main.decode("astronauts.json")
    let missons : [Mission] = Bundle.main.decode("missions.json")
    @State private var isShowCrewNames = false
    
    var body: some View {
        
//        VStack{
//            GeometryReader{ geo in
//                Image("kakashi")
//                    .resizable()
//                    .aspectRatio(contentMode : .fit)
//                    .frame(height: geo.size.height)
//            }
//        }
//        ScrollView(.vertical) {
//            VStack(spacing: 10) {
//                ForEach(0..<100) {
//                    Text("Item \($0)")
//                        .font(.title)
//                }
//            }
//            .frame(maxWidth: .infinity)
//        }
//        NavigationView {
//            List(0..<100) { row in
//                NavigationLink(destination: Text("Detail \(row)")) {
//                    Text("Row \(row)")
//                }
//            }
//            .navigationBarTitle("SwiftUI")
//        }
//        Button("Decode JSON") {
//            struct User: Codable {
//                var name: String
//                var address: Address
//            }
//
//            struct Address: Codable {
//                var street: String
//                var city: String
//            }
//
//            let input = """
//            {
//                "name": "Taylor Swift",
//                "address": {
//                    "street": "555, Taylor Swift Avenue",
//                    "city": "Nashville"
//                }
//            }
//            """
//            let data = Data(input.utf8)
//            let decoder = JSONDecoder()
//            if let user = try? decoder.decode(User.self, from: data) {
//                print(user.address.street)
//            }
//        }
        
        NavigationView {
            List(missons) { misson in
                NavigationLink(destination: MissionView(mission: misson, astronauts: self.astronauts, missions: self.missons)) {
                    Image(misson.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text(misson.displayName).font(.headline)
                        if self.isShowCrewNames {
                            HStack {
                                Text("Crew Names: \(misson.crewNames)")
                                    }
                        }
                        else {
                            Text(misson.formattedLaunchDate)
                            }
                    }
                }
            }
            .navigationBarTitle("MoonShot")
            .navigationBarItems(leading: Button(action: {
                isShowCrewNames.toggle()
            }){
              Text("Crew Names")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
