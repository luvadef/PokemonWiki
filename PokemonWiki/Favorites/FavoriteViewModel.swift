//
//  FavoriteViewModel.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 28-08-22.
//

import Combine
import Foundation

class FavoriteViewModel {
    var dataSource = FavoriteDataSource()
    @Published var favoriteList: [PokemonItem] = []

    init() {
        getFavoriteList()
    }

    func setFavorite(name: String, number: String, url: String) {
        let favoritePokemon = PokemonItem(name: name, number: number, url: url)
        dataSource.setFavorite(favorite: favoritePokemon)
    }

    func getFavoriteList() {
        dataSource.callFavoriteList(onCompletion: { list in
            guard let list = list else {
                return
            }
            self.favoriteList = list
        })
    }

    func isFavorite(name: String) -> Bool {
        return dataSource.callIsFavorite(name: name)
    }
}
