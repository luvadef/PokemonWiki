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
    @State private var showLoadder = false
    @State private var offset = 0

    var body: some View {
        VStack {
            HStack {
                NavigationView {
                    VStack {
                        List {
                            ForEach(pokemonItemList) { pokemon in
                                NavigationLink (destination: PokemonDetailView(pokemonName: pokemon.getSearchNumber())
                                ) {
                                    ListCellView(number: pokemon.number, name: pokemon.name)
                                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                                }
                                .frame(height: 75)
                            }
                        }
                        .onAppear {
                            UITableView.appearance().backgroundColor = UIColor(named: "SkyBlue")
                        }
                        HStack {
                            Button("Prev") {
                                showLoadder.toggle()
                                DispatchQueue.main.async {
                                    offset -= 20
                                    viewModel.getPokemonList(limit: 20, offset: offset)
                                    showLoadder.toggle()
                                }
                            }
                            .padding()
                            .foregroundColor(.white)
                            .disabled(offset == 0 ? true : false)
                            Rectangle()
                                .frame(maxHeight: 10)
                                .foregroundColor(.clear)
                            Divider().frame(maxHeight: 20)
                            Rectangle()
                                .frame(maxHeight: 10)
                                .foregroundColor(.clear)
                            Button("Next") {
                                showLoadder.toggle()
                                DispatchQueue.main.async {
                                    offset += 20
                                    viewModel.getPokemonList(limit: 20, offset: offset)
                                    showLoadder.toggle()
                                }
                            }
                            .padding()
                            .foregroundColor(.white)
                        }

                    }
                    .navigationTitle("Pokémon Wiki")
                    .background(UIColor(named: "LightBlue")?.toColor().edgesIgnoringSafeArea(.bottom))
                }
                .navigationViewStyle(.stack)
                .frame(maxWidth: .infinity)
                .font(Font.custom(FontsManager.PokemonGB.regular, size: 12))
                //Next develop
//                .searchable(text: $searchText, prompt: "Find a Pokémon") {
//                    //PokemonDetailView(pokemonName: searchText.lowercased())
//                }
//                .onSubmit(of: .search) {
//                    //showLoadder.toggle()
//                    print("Estoy buscando a: \(searchText)")
//                    viewModel.getPokemon(searchText.lowercased())
//                }
            }
        }
        .frame(maxWidth: .infinity)
        .onReceive(viewModel.$pokemonItemList) { list in
            pokemonItemList = list
        }

        if showLoadder {
            LottieView(fileName: "pokeball")
                .frame(width: 200, height: 200, alignment: .center)
        }
    }
    
}
