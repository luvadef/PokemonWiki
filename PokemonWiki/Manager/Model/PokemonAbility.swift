//
//  PokemonAbility.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 27-08-22.
//

import Foundation

struct PokemonAbility: Identifiable, Equatable, Codable {
    static func == (lhs: PokemonAbility, rhs: PokemonAbility) -> Bool {
        return lhs.id == rhs.id
    }

    let effectChanges: [JSONAny]
    let effectEntries: [EffectEntry]
    let flavorTextEntries: [FlavorTextEntry]
    let generation: Generation
    let id: Int
    let isMainSeries: Bool
    let name: String
    let names: [AbilityName]?
    let pokemon: [Pokemon]

    enum CodingKeys: String, CodingKey {
        case effectChanges = "effect_changes"
        case effectEntries = "effect_entries"
        case flavorTextEntries = "flavor_text_entries"
        case generation, id
        case isMainSeries = "is_main_series"
        case name, names, pokemon
    }
}

// MARK: - EffectEntry
struct EffectEntry: Codable {
    let effect: String
    var language: Generation
    let shortEffect: String

    enum CodingKeys: String, CodingKey {
        case effect, language
        case shortEffect = "short_effect"
    }
}

// MARK: - Generation
struct Generation: Codable {
    let name: String
    let url: String
}

// MARK: - FlavorTextEntry
struct FlavorTextEntry: Codable {
    let flavorText: String
    let language, versionGroup: Generation

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
        case versionGroup = "version_group"
    }
}

// MARK: - Name
struct AbilityName: Codable {
    let language: Generation
    let name: String
}

// MARK: - Pokemon
struct Pokemon: Codable {
    let isHidden: Bool
    let pokemon: Generation
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case pokemon, slot
    }
}

