//
//  PokemonList.swift
//  pokeTab
//
//  Created by harsh Khandelwal on 21/09/21.
//

import SwiftUI


struct PokemonList: View {
    init() {
            // 1.
        UINavigationBar.appearance().backgroundColor = UIColor(Color.hexStringToColor(hex: "#FFEFBA"))
        //UINavigationBar.appearance().accessibilityFrame
    }
    var body: some View {
        
        NavigationView{
            ZStack{
                
                List(pokemons){ pokemon in
                    NavigationLink(destination: PokemonView(pokemon: pokemon)){
                        PokemonRow(pokemon: pokemon)
                    }
                }.navigationBarTitle(Text("Favorite Pokemons")).navigationViewStyle(StackNavigationViewStyle()).navigationBarTitleDisplayMode(.inline)   
            }
        }
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
