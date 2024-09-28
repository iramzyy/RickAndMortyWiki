//
//  PrimaryButton.swift
//  DesignKit
//
//  Created by Ahmed Ramzy on 27/09/2024.
//

import SwiftUI
import Core

public struct PrimaryButton: View {
    public var title: String
    public var action: Action
    
    public init(title: String,
                action: @escaping Action) {
        self.title = title
        self.action = action
    }
    public var body: some View {
        Button {
            action()
        } label: {
            Text(title)
        }
        .frame(maxWidth: .infinity, minHeight: 36)
        .padding(.horizontal, 28)
        .padding(.vertical, 14)
        .background(DesignSystem.colors.primary)
        .foregroundStyle(DesignSystem.colors.white)
        .font(Font.fredoka(weight: .regular, size: 18))
        .clipShape(RoundedRectangle(cornerRadius: 8))

    }
}

#Preview {
    PrimaryButton(title: "Title",
                action: {
        print("Button Tapped")
    })
}
