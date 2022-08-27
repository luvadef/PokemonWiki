//
//  ListCellView.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 25-08-22.
//

import SwiftUI

struct ListCellView: View {
    var number: String
    var name: String
    var body: some View {
        HStack {
            Text("\(number)")
                .font(Font.custom(FontsManager.PokemonGB.regular, size: 18))
            Spacer()
            Text(name)
                .font(.custom(FontsManager.PokemonGB.regular, size: 18))
            Spacer()
        }
    }
}
