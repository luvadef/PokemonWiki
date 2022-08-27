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

    func dataFetchToDomain (
        _ value: PokemonDetail
    ) -> PokemonItemDetail {
        return PokemonItemDetail(
            abilities: value.abilities,
            baseExperience: value.baseExperience,
            forms: value.forms,
            gameIndices: value.gameIndices,
            height: value.height,
            heldItems: value.heldItems,
            id: value.id,
            isDefault: value.isDefault,
            locationAreaEncounters: value.locationAreaEncounters,
            moves: value.moves,
            name: value.name,
            order: value.order,
            pastTypes: value.pastTypes,
            species: value.species,
            sprites: value.sprites,
            stats: value.stats,
            types: value.types,
            weight: value.weight
        )
    }

    static func getSpritesArray(sprites: Sprites?) -> [SpriteData] {
        var spriteArray: [SpriteData] = []
        if let spriteFront = sprites?.frontDefault, !spriteFront.isEmpty {
            spriteArray.append(SpriteData(url: spriteFront, type: "Front Male"))
        }
        if let spriteBack = sprites?.backDefault, !spriteBack.isEmpty {
            spriteArray.append(SpriteData(url: spriteBack, type: "Back Male"))
        }
        if let spriteFrontFemale = sprites?.frontFemale, !spriteFrontFemale.isEmpty {
            spriteArray.append(SpriteData(url: spriteFrontFemale, type: "Front Female"))
        }
        if let spriteBackFemale = sprites?.backFemale, !spriteBackFemale.isEmpty {
            spriteArray.append(SpriteData(url: spriteBackFemale, type: "Back Female"))
        }
        if let spriteFrontShiny = sprites?.frontShiny, !spriteFrontShiny.isEmpty {
            spriteArray.append(SpriteData(url: spriteFrontShiny, type: "Front Shiny Male"))
        }
        if let spriteBackShiny = sprites?.backShiny, !spriteBackShiny.isEmpty {
            spriteArray.append(SpriteData(url: spriteBackShiny, type: "Back Shiny Male"))
        }
        if let spriteFrontShinyFemale = sprites?.frontShinyFemale, !spriteFrontShinyFemale.isEmpty {
            spriteArray.append(SpriteData(url: spriteFrontShinyFemale, type: "Front Shiny Female"))
        }
        if let spriteBackShinyFemale = sprites?.backShinyFemale, !spriteBackShinyFemale.isEmpty {
            spriteArray.append(SpriteData(url: spriteBackShinyFemale, type: "Back Shiny Female"))
        }
        return spriteArray
    }
}

struct SpriteData: Hashable {
    var url: String
    var type: String
}

enum SpriteType {
    case frontDefault
    case backDefault
    case frontFemale
    case backFemale
    case frontShiny
    case backShiny
    case frontShinyFemale
    case backShinyFemale
}
