//
//  ContentView.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 24-08-22.
//

import Combine
import Lottie
import SwiftUI

struct PokemonListView: View {
    var viewModel = PokemonListViewModel()
    @State private var pokemonItemList: [PokemonItem] = []
    @State private var searchText = ""
    @State private var showLoadder = true
    var body: some View {
        VStack {
            HStack {
                NavigationView {
                    List {
                        ForEach(pokemonItemList) { pokemon in
                            NavigationLink (destination: PokemonDetailView(pokemonName: pokemon.getSearchNumber())
                            ) {
                                ListCellView(number: pokemon.number, name: pokemon.name)
                            }
                                .frame(height: 75)
                        }
                    }
                    .onAppear {
                        UITableView.appearance().backgroundColor = UIColor(named: "SkyBlue")
                    }
                }
                .navigationViewStyle(.stack)
                .frame(maxWidth: .infinity)
                .font(Font.custom(FontsManager.PokemonGB.regular, size: 12))
                .searchable(text: $searchText, prompt: "Find a Pokémon")
                .onSubmit(of: .search) {
                    showLoadder.toggle()
                    print("Estoy buscando a: \(searchText)")
                    viewModel.getPokemon(searchText.lowercased())
                }
            }
        }
        .frame(maxWidth: .infinity)
        .onReceive(viewModel.$pokemonItemList) { list in
            pokemonItemList = list
        }
        .onAppear() {
            showLoadder.toggle()
        }
        
        if showLoadder {
            LottieView(fileName: "pokeball")
                .frame(width: 200, height: 200, alignment: .center)
        }
    }
}
