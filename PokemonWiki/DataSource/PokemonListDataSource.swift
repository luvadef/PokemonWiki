//
//  PokemonListDataSource.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 25-08-22.
//

import Foundation

class PokemonListDataSource {
    var mapper = DataMapper()
    func callListPokemon(limit: Int, offset: Int, onCompletion: @escaping ([PokemonItem]) -> Void) {
        print("calling network...")
        NetworkManager().listPokemon(limit: limit, offset: offset) { [weak self] (list, error) in
            guard self != nil else {
                return
            }
            guard let list = list else {
                return
            }
            print(list)
            onCompletion(self?.mapper.dataListToDomain(list) ?? [])
        }
    }
}
