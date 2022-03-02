//
//  AstronautView.swift
//  moonShot
//
//  Created by harsh Khandelwal on 16/10/21.
//

//import SwiftUI
//
//struct AstronautView: View {
//
//    var astronaut: Astronaut
//    var missions : [Mission]
//
//        var body: some View {
//            GeometryReader { geometry in
//                ScrollView(.vertical) {
//                    VStack {
//                        Image(self.astronaut.id)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: geometry.size.width)
//
//                        Text(self.astronaut.description)
//                            .padding()
//                        //layout priority was used if in any device the description is presented to us like this, "the congressional space medal of..." giving our astronaut description a layout priority of 1, which is higher than the image’s 0(as all have by default as 0), which means it will automatically take up all available space.
//
//                        VStack(alignment: .center){
//                            Text("All missions of this astronaut: ")
//                                .font(Font.system(size: 22, weight: .bold, design: .default))
//                            List(self.missions){ missions in
//                                Image(missions.image)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 44, height: 44)
//                                VStack(alignment: .leading){
//                                    Text(missions.displayName)
//                                        .font(.headline)
//                                    Text(missions.formattedLaunchDate)
//                                }
//                            }
//                        }
//
//                    }
//                }
//            }
//            .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
//        }
//    init(astronaut : Astronaut, missions: [Mission]){
//        self.astronaut = astronaut
//        self.missions = missions
//
//        var matches = [Mission]()
//
//        for mission in missions {
//            if mission.crew.first(where: {$0.name == self.astronaut.id}) != nil{
//                matches.append(mission)
//            }
//        }
//        self.missions = matches
//    }
//}
//
//struct AstronautView_Previews: PreviewProvider {
//    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
//    static let missions: [Mission] = Bundle.main.decode("missions.json")
//
//    static var previews: some View {
//        AstronautView(astronaut: astronauts[0], missions: missions)
//    }
//}
import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let font = Font.system(size: 22, weight: .bold, design: .default)
    var missions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                Image(self.astronaut.id)
                .resizable()
                .scaledToFit()
                    .frame(width: geometry.size.width)
                
                Text(self.astronaut.description)
                .padding()
                
                VStack(alignment: .center) {
                    Text("All missions of this astronaut: ")
                        .font(self.font)
                    
                    List(self.missions) { mission in
                        Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                            Text(mission.formattedLaunchDate)
                        }
                        
                    }
                }
               
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
        
    }
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        self.missions = missions
        
        var matches = [Mission]()
        
        for mission in missions {
            if let match = mission.crew.first(where: {$0.name == self.astronaut.id}) {
                matches.append(mission)
            }
        }
        self.missions = matches
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
