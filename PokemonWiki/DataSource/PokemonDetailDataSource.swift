//
//  PokemonDetailDataSource.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 28-08-22.
//

import Foundation

class PokemonDetailDataSource {

    var mapper = DataMapper()
    var cacheManager = CacheManager()
    var connectionManager = ConnectionManager()

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

    func savePokemonItemDetail(pokemonItemDetail: PokemonItemDetail) {
        _ = cacheManager.savePokemonItemDetail(pokemonItemDetail: pokemonItemDetail)
    }
}
