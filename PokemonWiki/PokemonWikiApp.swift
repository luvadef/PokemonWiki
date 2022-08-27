//
//  PokemonWikiApp.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 24-08-22.
//

import SwiftUI

@main
struct PokemonWikiApp: App {
    @State var showSplashScreen = true
    var body: some Scene {
        WindowGroup {
            ZStack {
                PokemonListView()
                    .onAppear( perform:  {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            withAnimation {
                                showSplashScreen.toggle()
                            }
                        })
                    })
                    .zIndex(0)
                if showSplashScreen {
                    splashScreen
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
                        .zIndex(1)
                }
            }.onAppear() {
                /// Uncomment to check available fonts
//                for family in UIFont.familyNames.sorted() {
//                    let names = UIFont.fontNames(forFamilyName: family)
//                    print("Family: \(family) Font names: \(names)")
//                }
            }
        }
    }
    var splashScreen = SplashScreenView()
}
