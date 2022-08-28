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
        static let pokemonAbility = "pokemon_ability"
        static let favorites = "favorites"
    }

    private let defaults = UserDefaults.standard

    func setFavorite(favoritePokemon: PokemonItem) -> Bool {
        var favoriteArray: [PokemonItem] = []
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        if let savedFavoriteList = defaults.object(forKey: Keys.favorites) as? Data {
            if let loadedFavoriteList = try? decoder.decode([PokemonItem].self, from: savedFavoriteList) {
                favoriteArray = loadedFavoriteList
                if favoriteArray.contains(where: { $0.name == favoritePokemon.name }) {
                    favoriteArray.removeAll(where: { $0.name == favoritePokemon.name })
                } else {
                    favoriteArray.append(favoritePokemon)
                }
            }
        } else {
            favoriteArray.append(favoritePokemon)
        }
        if let encoded = try? encoder.encode(favoriteArray) {
            defaults.set(encoded, forKey: Keys.favorites)
            if defaults.synchronize() {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }

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

    func savePokemonAbility(ability: PokemonAbility) -> Bool {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(ability) {
            defaults.set(encoded, forKey: Keys.pokemonAbility)
            if defaults.synchronize() {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }

    func getFavoriteList(onCompletion: @escaping ([PokemonItem]?) -> Void) {
        if let savedFavoriteList = defaults.object(forKey: Keys.favorites) as? Data {
            let decoder = JSONDecoder()
            if let loadedFavoriteList = try? decoder.decode([PokemonItem].self, from: savedFavoriteList) {
                onCompletion(loadedFavoriteList)
            }
        }
    }

    func getIsFavorite(favoriteName: String) -> Bool {
        var favoriteArray: [PokemonItem] = []
        let decoder = JSONDecoder()
        if let savedFavoriteList = defaults.object(forKey: Keys.favorites) as? Data {
            if let loadedFavoriteList = try? decoder.decode([PokemonItem].self, from: savedFavoriteList) {
                favoriteArray = loadedFavoriteList
                if favoriteArray.contains(where: { $0.name == favoriteName }) {
                    print("ES FAVORITO")
                    return true
                } else {
                    print("NO ES FAVORITO")
                    return false
                }
            }
        } else {
            return false
        }
        return false
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

    func getPokemonAbility(onCompletion: @escaping (PokemonAbilityDetail?) -> Void) {
        if let savedPokemonAbility = defaults.object(forKey: Keys.pokemonAbility) as? Data {
            let decoder = JSONDecoder()
            if let loadedPokemonAbility = try? decoder.decode(PokemonAbilityDetail.self, from: savedPokemonAbility) {
                onCompletion(loadedPokemonAbility)
            }
        }
    }
}

