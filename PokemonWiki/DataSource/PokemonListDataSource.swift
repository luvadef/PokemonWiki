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

    func callListPokemon(limit: Int, offset: Int, onCompletion: @escaping ([PokemonItem]?, NetworkError?) -> Void) {
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

    func callFetchPokemon(name: String, onCompletion: @escaping (PokemonItemDetail?, NetworkError?) -> Void) {
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

    func savePokemonItem(pokemonItemList: [PokemonItem]) {
        _ = cacheManager.savePokemonItemList(pokemonItemList: pokemonItemList)
    }

    func savePokemonItemDetail(pokemonItemDetail: PokemonItemDetail) {
        _ = cacheManager.savePokemonItemDetail(pokemonItemDetail: pokemonItemDetail)
    }
}
