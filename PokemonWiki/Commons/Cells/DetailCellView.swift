//
//  DetailCellView.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 26-08-22.
//

import SwiftUI

struct DetailCellView: View {
    var key, value: String
    var body: some View {
        HStack {
            Text(key)
            Spacer()
            Text(value)
        }
    }
}
