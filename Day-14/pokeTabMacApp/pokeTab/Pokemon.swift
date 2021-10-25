//
//  Pokemon.swift
//  pokeTab
//
//  Created by harsh Khandelwal on 21/09/21.
//

import Foundation

struct Pokemon: Identifiable{
    var id: Int
    var name: String
    var imageName: String
    var type: String
    var hp: Int
    var attack: Int
    var defense: Int
    var upperGradient : String
    var lowerGradient : String
}

let pokemons = [
    Pokemon(id: 0, name:"Charmander",imageName:"charmander", type:"fireType",hp:39,attack:52, defense:43,upperGradient: "#f12711",lowerGradient: "#f5af19"),
    Pokemon(id: 1, name:"Bulbasaur",imageName:"bulbasaur", type:"grassType",hp:45,attack:34, defense:43,upperGradient: "#1f4037",lowerGradient: "#99f2c8"),
    Pokemon(id: 2, name:"Squirtle",imageName:"squirtle", type:"waterType",hp:45,attack:43, defense:45,upperGradient: "#00B4DB",lowerGradient: "#0083B0"),
    Pokemon(id: 3, name:"Pikachu",imageName:"pikachu", type:"electricType",hp:45,attack:46, defense:32,upperGradient: "#CAC531",lowerGradient: "#F3F9A7"),
    Pokemon(id: 4, name:"Machop",imageName:"machop",type:"fightingType",hp:45,attack:43, defense:45,upperGradient: "#6D6027",lowerGradient: "#D3CBB8")
    ]
