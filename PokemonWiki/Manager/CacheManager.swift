//
//  CacheManager.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 27-08-22.
//

import Foundation

class CacheManager {
    enum Keys {
        static let pokemonItemList = "pokemon_item_list"
        static let pokemonItemDetail = "pokemon_item_detail"
    }

    private let defaults = UserDefaults.standard

    func savePokemonItemList(pokemonItemList: [PokemonItem]) -> Bool {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(pokemonItemList) {
            defaults.set(encoded, forKey: Keys.pokemonItemList)
            if defaults.synchronize() {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }

    func savePokemonItemDetail(pokemonItemDetail: PokemonItemDetail) -> Bool {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(pokemonItemDetail) {
            defaults.set(encoded, forKey: Keys.pokemonItemDetail)
            if defaults.synchronize() {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }

    func getPokemonItemList(onCompletion: @escaping ([PokemonItem]?) -> Void) {
        if let savedPokemonItemList = defaults.object(forKey: Keys.pokemonItemList) as? Data {
            let decoder = JSONDecoder()
            if let loadedPokemonItemList = try? decoder.decode([PokemonItem].self, from: savedPokemonItemList) {
                onCompletion(loadedPokemonItemList)
            }
        }
    }

    func getPokemonItemDetail(onCompletion: @escaping (PokemonItemDetail?) -> Void) {
        if let savedPokemonItemDetail = defaults.object(forKey: Keys.pokemonItemDetail) as? Data {
            let decoder = JSONDecoder()
            if let loadedPokemonItemDetail = try? decoder.decode(PokemonItemDetail.self, from: savedPokemonItemDetail) {
                onCompletion(loadedPokemonItemDetail)
            }
        }
    }
}

