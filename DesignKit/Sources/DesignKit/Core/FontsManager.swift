//
//  FontsManager.swift
//  DesignKit
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import Foundation
import SwiftUI

public class FontsManager {
    public static func loadFonts(fontNames: [String]) {
        for fileName in fontNames {
            if let fontURL = Bundle.module.url(forResource: fileName, withExtension: "ttf"),
               let fontData = try? Data(contentsOf: fontURL) {
                if let provider = CGDataProvider(data: fontData as CFData),
                   let font = CGFont(provider) {
                    if CTFontManagerRegisterGraphicsFont(font, nil) {
                        print("Font \(fileName) registered successfully")
                    } else {
                        print("Font \(fileName) registration failed")
                    }
                }
            }
        }
    }
}


public func rickAndMortyFontNames() -> [String] {
    return [
        "Fredoka-Bold",
        "Fredoka-Light",
        "Fredoka-Medium",
        "Fredoka-Regular",
        "Fredoka-SemiBold"
    ]
}

public extension Font {
    static func fredoka(weight: FredokaFontWeight, size: CGFloat) -> Font {
        return Font.custom("Fredoka-\(weight.rawValue)", size: size)
    }
}

public enum FredokaFontWeight: String {
    case bold = "Bold"
    case semiBold = "SemiBold"
    case medium = "Medium"
    case regular = "Regular"
    case light = "Light"
}


