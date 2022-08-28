//
//  PokemonListViewModel.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 24-08-22.
//

import Combine
import Foundation

class PokemonListViewModel {
    var dataSource = PokemonListDataSource()
    @Published var pokemonItemList: [PokemonItem] = []
    @Published var pokemonItemDetail: PokemonItemDetail = PokemonItemDetail.getEmptyPokemon()
    
    init() {
        getPokemonList(limit: 20, offset: 0)
    }

    func getPokemonList(limit: Int, offset: Int) {
        dataSource.callListPokemon(limit: limit, offset: offset, onCompletion: { (list, error) in
            guard let list = list else {
                return
            }
            self.pokemonItemList = list
        })
    }

    func getPokemon(_ name: String) {
        dataSource.callFetchPokemon(name: name, onCompletion: { (pokemon, error) in
            guard let pokemon = pokemon else {
                return
            }
            self.pokemonItemDetail = pokemon
            print(self.pokemonItemDetail)
        })
    }
}
