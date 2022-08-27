//
//  PokemonList.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 24-08-22.
//

import Foundation

// MARK: - PokemonList
struct PokemonList: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let name: String
    let url: String
}
