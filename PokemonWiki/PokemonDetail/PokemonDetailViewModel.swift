//
//  PokemonDetailViewModel.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 25-08-22.
//

import Combine
import Foundation
import SwiftUI

class PokemonDetailViewModel {
    var dataSource = PokemonListDataSource()
    @Published var pokemonItemDetail: PokemonItemDetail = PokemonItemDetail.getEmptyPokemon()
    @Published var showNetworkError: Bool = false
    
    func getPokemon(_ name: String) {
        dataSource.callFetchPokemon(name: name, onCompletion: { (pokemon, error) in
            guard let pokemon = pokemon else {
                guard let error = error else {
                    return
                }
                if error == NetworkError.apiError {
                    self.showNetworkError = true
                }
                return
            }
            self.pokemonItemDetail = pokemon
        })
    }
}




