//
//  PokemonListModel.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 25-08-22.
//

import Foundation

// MARK: - PokemonItem
struct PokemonItem: Identifiable {
    let id = UUID()
    let name: String
    let number: String
    let url: String
}
