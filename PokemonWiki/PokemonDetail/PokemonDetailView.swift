//
//  PokemonDetailView.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 25-08-22.
//

import SwiftUI

struct PokemonDetailView: View {
    var pokemonName: String
    var pokemonURL: String
    var viewModel = PokemonDetailViewModel()
    var favoriteViewModel = FavoriteViewModel()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) private var presentationMode
    @State private var pokemonItemDetail: PokemonItemDetail = PokemonItemDetail.getEmptyPokemon()
    @State private var pokemonAbilityDetail: PokemonAbilityDetail = PokemonAbilityDetail.getEmptyAbilityDetail()
    @State private var isFavorite = false
    @State var showingAlertPopup = false
    @State var showingAbilityPopup = false
    @State private var showLoadder = false
    @State private var showFavorite = false

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
        .shadow(radius: 5)
    }

    var abilities: some View {
        VStack {
            ForEach(0 ..< pokemonItemDetail.getAbilities().count, id: \.self) { index in
                HStack {
                    Spacer()
                    PokemonText(text: pokemonItemDetail.getAbilities()[index], size: 12).pokemonText
                    Spacer()
                    Image("Arrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }
                .onTapGesture {
                    DispatchQueue.main.async {
                        viewModel.getAbility(pokemonItemDetail.abilities[index].ability.url)
                        showingAbilityPopup.toggle()
                      }
                }
                .onReceive(viewModel.$pokemonAbilityDetail) { ability in
                        pokemonAbilityDetail = ability
                }
                if index < pokemonItemDetail.getAbilities().count - 1 {
                    Divider()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }

    var stats: some View {
        VStack {
            ForEach(0 ..< pokemonItemDetail.stats.count, id: \.self) { index in
                HStack {
                    PokemonText(
                        text: "\(pokemonItemDetail.stats[index].stat.name): \(String(pokemonItemDetail.stats[index].baseStat))",
                        size: 12
                    ).pokemonText
                }
                if index < pokemonItemDetail.stats.count - 1 {
                    Divider()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }

    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                Rectangle()
                    .frame(minHeight: 20)
                    .foregroundColor(.clear)
                PokemonText(text: "Images", size: 18).pokemonText
                carousel
                Toggle("Favorite", isOn: $isFavorite)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .onTapGesture {
                        favoriteViewModel.setFavorite(
                            name: pokemonItemDetail.name,
                            number: pokemonName,
                            url: pokemonURL
                        )
                        if !isFavorite {
                            showFavorite.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                withAnimation {
                                    showFavorite.toggle()
                                }
                            })
                        }
                    }
                VStack {
                    Rectangle()
                        .frame(minHeight: 10)
                        .foregroundColor(.clear)
                    PokemonText(text: "Details", size: 18).pokemonText
                    detail
                    Rectangle()
                        .frame(minHeight: 20)
                        .foregroundColor(.clear)
                    PokemonText(text: "Stats", size: 18).pokemonText
                    stats
                    Rectangle()
                        .frame(minHeight: 20)
                        .foregroundColor(.clear)
                    PokemonText(text: "Abilities", size: 18).pokemonText
                    abilities
                    Rectangle()
                        .frame(minHeight: 20)
                        .foregroundColor(.clear)
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))

            }
            .frame(maxHeight: .infinity)

            if showingAlertPopup {
                ZStack {
                    VStack {
                        Text("Sorry!")
                            .foregroundColor(.black)
                            .font(Font.custom(FontsManager.PokemonGB.regular, size: 18))
                            .padding()
                        Divider()
                        PokemonText(
                            text: "We couldn't load the information of this pokemon",
                            size: 14
                        )
                        .pokemonText
                        Divider()
                        Button("Back") {
                            handleDismiss()
                        }
                        .font(Font.custom(FontsManager.PokemonGB.regular, size: 18))
                        .padding()
                    }
                    .frame(width: 300, height: 200, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.brown)
            }
            if showingAbilityPopup {
                VStack {
                    PokemonText(text: pokemonAbilityDetail.name, size: 18)
                    .pokemonText
                    Divider()
                    if pokemonAbilityDetail.effectEntries.count > 0 {
                        ForEach(0 ..< pokemonAbilityDetail.effectEntries.count, id: \.self) { index in
                            if pokemonAbilityDetail.effectEntries[index].language.name == "en" {
                                Text(pokemonAbilityDetail.effectEntries[index].shortEffect)
                                    .font(Font.custom(FontsManager.PokemonGB.regular, size: 12))
                                    .padding()
                            }
                        }
                    }
                    Divider()
                    Button("Back") {
                        showingAbilityPopup.toggle()
                    }
                    .font(Font.custom(FontsManager.PokemonGB.regular, size: 18))
                }
                .frame(width: 300, height: 250, alignment: .center)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
            }
            if showLoadder {
                LottieView(fileName: "pokeball")
                    .frame(width: 200, height: 200, alignment: .center)
            }
            if showFavorite {
                LottieView(fileName: "favorite")
                    .frame(width: 200, height: 200, alignment: .center)
            }
        }
        .onAppear() {
            viewModel.getPokemon(pokemonName)
        }
        .onReceive(viewModel.$pokemonItemDetail) { detail in
            pokemonItemDetail = detail
            if favoriteViewModel.isFavorite(name: pokemonItemDetail.name) {
                isFavorite.toggle()
            }
//            showLoadder.toggle()
            if pokemonItemDetail.id != 0 {
                showingAlertPopup.toggle()
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

struct AbilityPopUP {
    var title: String
    var text: String
    var pokePopup: some View {
        VStack {
            Text(title)
                .font(Font.custom(FontsManager.PokemonGB.regular, size: 18))
                .foregroundColor(.black)
                .frame(minHeight: 50)
                .background(.clear)
            Divider()
            Text(text)
                .font(Font.custom(FontsManager.PokemonGB.regular, size: 12))
                .foregroundColor(.black)
                .frame(minHeight: 50)
                .background(.clear)
            Button("OK") {

            }
            .font(Font.custom(FontsManager.PokemonGB.regular, size: 18))
        }
        .frame(width: 300, height: 200, alignment: .center)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}


