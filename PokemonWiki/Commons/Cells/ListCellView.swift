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
            Spacer()
            Text(name)
            Spacer()
        }
    }
}
