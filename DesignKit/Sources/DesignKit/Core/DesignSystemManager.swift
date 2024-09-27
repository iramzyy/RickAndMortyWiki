//
//  DesignSystemManager.swift
//  DesignKit
//
//  Created by Ahmed Ramzy on 27/09/2024.
//

import Foundation
import SwiftUI

public class DesignSystem {
    public static var shared = DesignSystem()
    public var designSystem: DesignSystemModel!
    public static var colors = DesignSystem.shared.designSystem.colors

    public init() {
        designSystem = defaultDesignSystem
        FontsManager.loadFonts(fontNames: rickAndMortyFontNames())
    }

    public func setup() {
        self.designSystem = defaultDesignSystem

    }
}

