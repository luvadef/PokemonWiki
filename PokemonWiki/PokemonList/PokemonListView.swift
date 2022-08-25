//
//  ContentView.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 24-08-22.
//

import Combine
import SwiftUI

struct PokemonListView: View {
    var viewModel = PokemonListViewModel()
    @State private var pokemonItemList: [PokemonItem] = []
    var body: some View {
        VStack {
            Text("Lista de Pokémones")
            List {
                ForEach(pokemonItemList) { pokemon in
                    ListCellView(number: pokemon.number, name: pokemon.name)
                        .onTapGesture {
                            print("Apreté pokémon: \(pokemon.name)")
                        }
                }
            }
            .listStyle(.insetGrouped)
        }
        .onReceive(viewModel.$pokemonItemList) { list in
            pokemonItemList = list
        }
    }

}
