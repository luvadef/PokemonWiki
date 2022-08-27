//
//  CarrouselItemView.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 26-08-22.
//

import SwiftUI

struct CarrouselItemView: View {
    var imageURL: String
    var imageName: String
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: imageURL))
                .frame(width: 80, height: 100, alignment: .center)
                .scaledToFill()
            Text(imageName)
                .font(Font.custom(FontsManager.PokemonGB.regular, size: 18))
                .padding()
        }
        .frame(width: 150, height: 150)
    }
}
