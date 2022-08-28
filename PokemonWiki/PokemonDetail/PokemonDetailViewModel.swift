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
    var dataSource = PokemonDetailDataSource()
    @Published var pokemonItemDetail: PokemonItemDetail = PokemonItemDetail.getEmptyPokemon()
    @Published var pokemonAbilityDetail: PokemonAbilityDetail = PokemonAbilityDetail.getEmptyAbilityDetail()
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

    func getAbility(_ url: String) {
        dataSource.callAbilityPokemon(url: url, onCompletion: { (ability, error) in
            guard let ability = ability else {
                guard let error = error else {
                    return
                }
                if error == NetworkError.apiError {
                    self.showNetworkError = true
                }
                return
            }
            //print(self.pokemonAbilityDetail)
            self.pokemonAbilityDetail = ability
        })
    }
}




