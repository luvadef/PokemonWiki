//
//  SplashScreenView.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 24-08-22.
//

import Lottie
import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 125, alignment: .center)
                Image("Wiki")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 125, height: 125, alignment: .center)
            }
            Spacer()
            LottieView(fileName: "digglet").frame(width: 350, height: 250, alignment: .bottom)
        }
        .background(Color.white)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
