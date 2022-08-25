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

    init(){
        getPokemonList(limit: 20, offset: 0)
    }

    func getPokemonList(limit: Int, offset: Int) {
        dataSource.callListPokemon(limit: limit, offset: offset, onCompletion: { list in
            self.pokemonItemList = list
        })
    }

    func callFetchPokemon(name: String) {
        print("calling network...")
        NetworkManager().fetchPokemon(name: name) { [weak self] (pokemon, error) in
            guard self != nil else { return }
            if let pokemon = pokemon {
                print("~~~~~~~~~~~~~~~~~~~~~~~~")
                print("POKEMON: \(pokemon)")
                print("~~~~~~~~~~~~~~~~~~~~~~~~")
            } else {
                print("No pokemon found!!")
            }
        }
    }
}
