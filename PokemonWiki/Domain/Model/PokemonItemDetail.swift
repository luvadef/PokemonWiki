//
//  PokemonItemDetail.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 25-08-22.
//

import Foundation

// MARK: - PokemonItemDetail
struct PokemonItemDetail: Identifiable, Equatable, Codable {
    static func == (lhs: PokemonItemDetail, rhs: PokemonItemDetail) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }

    let abilities: [Ability]
    let baseExperience: Int
    let forms: [Species]
    let gameIndices: [GameIndex]
    let height: Int
    let heldItems: [JSONAny]
    let id: Int
    let isDefault: Bool
    let locationAreaEncounters: String
    let moves: [Move]
    let name: String
    let order: Int
    let pastTypes: [JSONAny]
    let species: Species?
    let sprites: Sprites?
    let stats: [Stat]
    let types: [TypeElement]
    let weight: Int

    static func getEmptyPokemon() -> PokemonItemDetail {
        return PokemonItemDetail (
            abilities: [],
            baseExperience: 0,
            forms: [],
            gameIndices: [],
            height: 0,
            heldItems: [],
            id: PokemonID.empty,
            isDefault: false,
            locationAreaEncounters: "",
            moves: [],
            name: "",
            order: 0,
            pastTypes: [],
            species: nil,
            sprites: nil,
            stats: [],
            types: [],
            weight: 0
        )
    }

    static func getNoAPIResponsePokemon() -> PokemonItemDetail {
        return PokemonItemDetail (
            abilities: [],
            baseExperience: 0,
            forms: [],
            gameIndices: [],
            height: 0,
            heldItems: [],
            id: PokemonID.noAPIResponse,
            isDefault: false,
            locationAreaEncounters: "",
            moves: [],
            name: "",
            order: 0,
            pastTypes: [],
            species: nil,
            sprites: nil,
            stats: [],
            types: [],
            weight: 0
        )
    }

    func getAbilities() -> [String] {
        var abilitiesArray: [String] = []
        for ability in abilities {
            abilitiesArray.append(ability.ability.name)
        }
        return abilitiesArray
    }


}



enum PokemonID {
    static var empty = -1
    static var noAPIResponse = 0
}
