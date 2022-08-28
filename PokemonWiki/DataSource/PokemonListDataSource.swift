//
//  PokemonListDataSource.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 25-08-22.
//

import Foundation

class PokemonListDataSource {
    var mapper = DataMapper()
    var cacheManager = CacheManager()
    var connectionManager = ConnectionManager()

    func networkCallListPokemon(limit: Int, offset: Int, onCompletion: @escaping ([PokemonItem]?, NetworkError?) -> Void) {
        print("calling network...")
        NetworkManager().listPokemon(limit: limit, offset: offset) { [weak self] (list, error) in
            guard self != nil, let list = list else {
                if let error = error as? NetworkError {
                    onCompletion(nil, error)
                }
                return
            }
            let pokemonItemList = self?.mapper.dataListToDomain(list) ?? []
            self?.savePokemonItem(pokemonItemList: pokemonItemList)
            onCompletion(pokemonItemList, nil)
        }
    }

    func callListPokemon(limit: Int, offset: Int, onCompletion: @escaping ([PokemonItem]?, NetworkError?) -> Void) {
        connectionManager.isConnected(onCompletion: { available in
            if available {
                self.networkCallListPokemon(limit: limit, offset: offset) { pokemonItemList, error in
                    onCompletion(pokemonItemList, error)
                }
            } else {
                self.cacheManager.getPokemonItemList { pokemonItemList in
                    onCompletion(pokemonItemList, nil)
                }
            }
        })
    }

    func networkCallFetchPokemon(name: String, onCompletion: @escaping (PokemonItemDetail?, NetworkError?) -> Void) {
        print("calling network...")
        NetworkManager().fetchPokemon(name: name) { [weak self] (pokemon, error) in
            guard self != nil, let pokemon = pokemon else {
                if let error = error as? NetworkError {
                    onCompletion(nil, error)
                }
                return
            }
            onCompletion(self?.mapper.dataFetchToDomain(pokemon) ?? PokemonItemDetail.getNoAPIResponsePokemon(), nil)
        }
    }

    func callFetchPokemon(name: String, onCompletion: @escaping (PokemonItemDetail?, NetworkError?) -> Void) {
        connectionManager.isConnected(onCompletion: { available in
            if available {
                self.networkCallFetchPokemon(name: name) { pokemonDetail, error in
                    onCompletion(pokemonDetail, error)
                }
            } else {
                self.cacheManager.getPokemonItemDetail { pokemonDetail in
                    onCompletion(pokemonDetail, nil)
                }
            }
        })
    }

    func networkCallAbilityPokemon(url: String, onCompletion: @escaping (PokemonAbilityDetail?, NetworkError?) -> Void) {
        print("calling network...")
        NetworkManager().abilityPokemon(url: url) { [weak self] (ability, error) in
            guard self != nil, let ability = ability else {
                if let error = error as? NetworkError {
                    onCompletion(nil, error)
                }
                return
            }
            onCompletion(self?.mapper.dataAbilityToDomain(ability) ?? PokemonAbilityDetail.getNoAPIResponseAbilityDetail(), nil)
        }
    }

    func callAbilityPokemon(url: String, onCompletion: @escaping (PokemonAbilityDetail?, NetworkError?) -> Void) {

        connectionManager.isConnected(onCompletion: { available in
            if available {
                self.networkCallAbilityPokemon(url: url) { ability, error in
                    onCompletion(ability, error)
                }

            } else {
                self.cacheManager.getPokemonAbility { pokemonAbility in
                    onCompletion(pokemonAbility, nil)
                }
            }

        })
    }

    func savePokemonItem(pokemonItemList: [PokemonItem]) {
        _ = cacheManager.savePokemonItemList(pokemonItemList: pokemonItemList)
    }

    func savePokemonItemDetail(pokemonItemDetail: PokemonItemDetail) {
        _ = cacheManager.savePokemonItemDetail(pokemonItemDetail: pokemonItemDetail)
    }
}
