//
//  PokemonDetailView.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 25-08-22.
//

import SwiftUI

struct PokemonDetailView: View {
    var pokemonName: String
    var viewModel = PokemonDetailViewModel()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) private var presentationMode
    @State private var pokemonItemDetail: PokemonItemDetail = PokemonItemDetail.getEmptyPokemon()
    @State private var isFavorite = false
    @State var showingPopup = false

    var carousel: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(DataMapper.getSpritesArray(sprites: pokemonItemDetail.sprites), id: \.self) { sprite in
                        VStack {
                            AsyncImage(url: URL(string: sprite.url))
                                .scaledToFill()
                                .clipped()
                            PokemonText(
                                text: sprite.type,
                                size: 12,
                                color: .black
                            )
                                .pokemonText
                                .frame(maxWidth: .infinity)
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 150, alignment: .center)
    }

    var detail: some View {
        VStack {
            PokemonText(
                text: "Order: \(pokemonItemDetail.order)",
                size: 12
            )
            .pokemonText
            Divider()
            PokemonText(
                text: "Height: \(pokemonItemDetail.height)",
                size: 12
            )
            .pokemonText
            Divider()
            PokemonText(
                text: "Weight: \(pokemonItemDetail.weight)",
                size: 12
            )
            .pokemonText
            Divider()
            PokemonText(
                text: "Initial: \(pokemonItemDetail.isDefault ? "YES" : "NO")",
                size: 12
            )
            .pokemonText
            Divider()
            PokemonText(
                text: "Base Experience: \(pokemonItemDetail.baseExperience) pts",
                size: 12
            )
            .pokemonText
        }
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        .background(.white)
        .cornerRadius(10)
    }

    var abilities: some View {
        VStack {
            ForEach(0 ..< pokemonItemDetail.getAbilities().count, id: \.self) { index in
                PokemonText(text: pokemonItemDetail.getAbilities()[index], size: 12).pokemonText
                if index < pokemonItemDetail.getAbilities().count - 1 {
                    Divider()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        .background(.white)
        .cornerRadius(10)
    }

    var stats: some View {
        List {//(pokemonItemDetail.stats, children: \.items) { row in

        }
    }

    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                PokemonText(text: "Images", size: 18).pokemonText
                carousel
                VStack {
                    //Toggle("Favorite", isOn: $isFavorite)
                    Rectangle()
                        .frame(minHeight: 20)
                        .foregroundColor(.clear)
                    PokemonText(text: "Details", size: 18).pokemonText
                    detail
                    Rectangle()
                        .frame(minHeight: 20)
                        .foregroundColor(.clear)
                    PokemonText(text: "Abilities", size: 18).pokemonText
                    abilities
//                    Button("Go back") {
//                        handleDismiss()
//                    }
//                        .buttonStyle(.borderedProminent)
//                        .controlSize(.large)
//                        .frame(alignment: .bottom)
//                        .font(Font.custom(FontsManager.PokemonGB.regular, size: 18))
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))

            }
            .frame(maxHeight: .infinity)

            if showingPopup {
                VStack {
                    PokemonText(
                        text: "No se ha encontrado información del Pokémon",
                        size: 14
                    )
                        .pokemonText
                    Button("Back") {
                        handleDismiss()
                    }
                    .font(Font.custom(FontsManager.PokemonGB.regular, size: 18))
                }
                .frame(width: 300, height: 200, alignment: .center)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
            }
        }
        .onAppear() {
            viewModel.getPokemon(pokemonName)
        }
        .onReceive(viewModel.$pokemonItemDetail) { detail in
            pokemonItemDetail = detail
            if pokemonItemDetail.id == 0 {
                showingPopup = true
            }
        }
        .background(UIColor(named: "SkyBlue")?.toColor().edgesIgnoringSafeArea(.top))
        .background(UIColor(named: "SkyBlue")?.toColor().edgesIgnoringSafeArea(.bottom))
        .navigationTitle(pokemonItemDetail.name.uppercased())
    }
}

private extension PokemonDetailView {
    func handleDismiss() {
        if #available(iOS 15, *) {
            dismiss()
        } else {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct PokemonText {
    var text: String
    var size: CGFloat
    var color: Color? = .black
    var pokemonText: some View {
        Text(text)
            .font(Font.custom(FontsManager.PokemonGB.regular, size: size))
            .foregroundColor(color)
            .frame(minHeight: size)
            .background(.clear)
    }
}


