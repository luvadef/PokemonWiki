//
//  DataMapper.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 25-08-22.
//

import Foundation

struct DataMapper {
    func dataListToDomain (
        _ value: PokemonList
    ) -> [PokemonItem] {
        var pokemonItemList: [PokemonItem] = []

        for pokemon in value.results {
            let arrayURL = pokemon.url.split(separator: "/")
            let number = getNumberWithZero(Int(arrayURL[arrayURL.count - 1]) ?? -1)
            pokemonItemList.append(PokemonItem(name: pokemon.name, number: number, url: pokemon.url))
        }
        return pokemonItemList
    }

    private func getNumberWithZero(_ number: Int) -> String {
        if number < 10 {
            return "0\(number)"
        } else {
            return "\(number)"
        }
    }
}
