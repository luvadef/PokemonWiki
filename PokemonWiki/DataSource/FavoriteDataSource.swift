//
//  FavoriteDataSource.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 28-08-22.
//

import Foundation

class FavoriteDataSource {
    var mapper = DataMapper()
    var cacheManager = CacheManager()

    func callFavoriteList(onCompletion: @escaping ([PokemonItem]?)-> Void) {
        self.cacheManager.getFavoriteList { pokemonItemList in
            onCompletion(pokemonItemList)
        }
    }

    func callIsFavorite(name: String) -> Bool {
        return self.cacheManager.getIsFavorite(favoriteName: name)
    }

    func setFavorite(favorite: PokemonItem) {
        _ = cacheManager.setFavorite(favoritePokemon: favorite)
    }
}
