//
//  FavoriteView.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 28-08-22.
//

import SwiftUI

struct FavoriteView: View {

    var viewModel = FavoriteViewModel()
    @State private var favoriteList: [PokemonItem] = []

    var body: some View {
        VStack {
            if favoriteList.count > 0 {
                List {
                    ForEach(favoriteList) { pokemon in
                        NavigationLink (
                            destination: PokemonDetailView(
                                pokemonName: pokemon.getSearchNumber(),
                                pokemonURL: pokemon.url
                            )
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
                .navigationTitle("Favorites")
            } else {
                VStack {
                    Text("There are no Pokémon in your favorites list yet.").padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(UIColor(named: "SkyBlue")?.toColor().edgesIgnoringSafeArea(.top))
                .background(UIColor(named: "SkyBlue")?.toColor().edgesIgnoringSafeArea(.bottom))
            }
        }
        .frame(maxWidth: .infinity)
        .onReceive(viewModel.$favoriteList) { list in
            favoriteList = list
        }
        .onAppear() {
            viewModel.getFavoriteList()
        }
    }
}
