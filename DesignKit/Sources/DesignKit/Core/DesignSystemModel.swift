//
//  DesignSystemModel.swift
//  DesignKit
//
//  Created by Ahmed Ramzy on 27/09/2024.
//


import SwiftUI

public class DesignSystemModel {
    public let colors: ColorValueContainer

    public init(colors: ColorValueContainer) {
        self.colors = colors
    }
}

public struct ColorValueContainer {
    public let primary: Color
    public let secondary: Color
    public let white: Color
    public let black: Color
    public let warning: Color
    public let danger: Color

    public init(primary: Color,
                secondary: Color,
                white: Color,
                black: Color,
                warning: Color,
                danger: Color) {
        self.primary = primary
        self.secondary = secondary
        self.white = white
        self.black = black
        self.warning = warning
        self.danger = danger
    }
}
