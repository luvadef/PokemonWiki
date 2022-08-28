//
//  PokemonAbility.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 27-08-22.
//

import Foundation

// MARK: - PokemonAbilityDetail
struct PokemonAbilityDetail: Identifiable, Equatable, Codable {
    static func == (lhs: PokemonAbilityDetail, rhs: PokemonAbilityDetail) -> Bool {
        return lhs.id == rhs.id
    }

    let effectChanges: [JSONAny]
    let effectEntries: [EffectEntry]
    let flavorTextEntries: [FlavorTextEntry]
    let generation: Generation?
    let id: Int
    let isMainSeries: Bool
    let name: String
    let names: [AbilityName]?
    let pokemon: [Pokemon]?

    enum CodingKeys: String, CodingKey {
        case effectChanges = "effect_changes"
        case effectEntries = "effect_entries"
        case flavorTextEntries = "flavor_text_entries"
        case generation, id
        case isMainSeries = "is_main_series"
        case name, names, pokemon
    }

    static func getEmptyAbilityDetail() -> PokemonAbilityDetail {
        return PokemonAbilityDetail (
            effectChanges: [],
            effectEntries: [],
            flavorTextEntries: [],
            generation: nil,
            id: 0,
            isMainSeries: false,
            name: "",
            names: [],
            pokemon: nil
        )
    }

    static func getNoAPIResponseAbilityDetail() -> PokemonAbilityDetail {
        return PokemonAbilityDetail (
            effectChanges: [],
            effectEntries: [],
            flavorTextEntries: [],
            generation: nil,
            id: -1,
            isMainSeries: false,
            name: "",
            names: [],
            pokemon: nil
        )
    }
}
