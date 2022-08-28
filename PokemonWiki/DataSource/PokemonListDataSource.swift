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



    func savePokemonItem(pokemonItemList: [PokemonItem]) {
        _ = cacheManager.savePokemonItemList(pokemonItemList: pokemonItemList)
    }


}
