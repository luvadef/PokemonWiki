//
//  UIColor.swift
//  PokemonWiki
//
//  Created by Luis Valdés on 25-08-22.
//

import Foundation
import UIKit
import SwiftUI

extension UIColor {
    func toColor() -> Color {
        guard let components = cgColor.components, components.count >= 3 else {
            return Color.clear
        }
        return Color(
            red: Double(components[0]),
            green: Double(components[1]),
            blue: Double(components[2])
        )
    }
}
