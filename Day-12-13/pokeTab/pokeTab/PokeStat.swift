//
//  PokeStat.swift
//  pokeTab
//
//  Created by harsh Khandelwal on 21/09/21.
//

import SwiftUI

struct PokeStat: View {
    var statName: String
    var statValue: String
    var statSymbol: String
    
    var body: some View {
     
        HStack {
            Image(systemName:statSymbol)
            .font(.system(size:25))
            .padding(.leading,20)
            Text(statName)
            .font(.system(size:25)) .fontWeight(.bold) .padding(.leading,20)
            Text(statValue).font(.system(size:25))
            Spacer()
        }
    }
}

struct PokeStat_Previews: PreviewProvider {
    static var previews: some View {
        PokeStat(statName: "", statValue: "", statSymbol: "")
    }
}
