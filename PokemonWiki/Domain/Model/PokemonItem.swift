//
//  PokemonListModel.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 25-08-22.
//

import Foundation

// MARK: - PokemonItem
struct PokemonItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let number: String
    let url: String

    func getSearchNumber() -> String {
        let arrayURL = url.split(separator: "/")
        return String(arrayURL[arrayURL.count - 1])
    }
}
