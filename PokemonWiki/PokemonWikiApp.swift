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
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
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
            }
        }
    }
    var splashScreen = SplashScreenView()
}
