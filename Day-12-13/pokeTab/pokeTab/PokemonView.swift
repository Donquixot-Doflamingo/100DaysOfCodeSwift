//
//  ContentView.swift
//  pokeTab
//
//  Created by harsh Khandelwal on 19/09/21.
//

import SwiftUI
import CoreData

extension Color {
    static func hexStringToColor (hex:String, opacity: Double = 0.7) -> Color {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            return Color.gray
        }
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        return Color(
            red: Double((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: Double((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgbValue & 0x0000FF) / 255.0,
            opacity: Double(opacity)
        )
    }
}

struct PokemonView: View {
    var pokemon: Pokemon
    var body: some View {
        let gradient = Gradient(colors: [Color.hexStringToColor(hex: String(pokemon.upperGradient)),Color.hexStringToColor(hex: pokemon.lowerGradient)])
        ScrollView{
            VStack {
                Image(pokemon.type).resizable().frame(width: 300, height: 250.0).offset(x:0,y:-10)
                Image(pokemon.imageName).resizable().padding(.horizontal, 10.0).frame(height: 300.0) .clipShape(Circle()).shadow(radius: 10).offset(x:0,y:-150).padding(.bottom,-150)
                Text(pokemon.name).font(.system(size:50)).fontWeight(.bold)
            
                PokeStat(statName: "HP",statValue: String(pokemon.hp), statSymbol: "heart")
                PokeStat(statName: "Attack", statValue: String(pokemon.attack), statSymbol: "star")
                PokeStat(statName: "Defense", statValue: String(pokemon.defense), statSymbol: "shield")
                
                Spacer()
            }.edgesIgnoringSafeArea(.top)
        }.background( LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
    }
}
        
struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
       PokemonView(pokemon: pokemons[0])
    }
}
