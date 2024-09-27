//
//  CharacterStatusTag.swift
//  DesignKit
//
//  Created by Ahmed Ramzy on 27/09/2024.
//

import SwiftUI

public enum CharacterStatus: String {
    case alive = "Alive 🚀"
    case dead = "Dead ☠️"
    case unknown = "Unknown 🔎"
    
    func getBackgroundColor() -> Color {
        switch self {
        case .alive:
            return DesignSystem.colors.secondary
        case .dead:
            return DesignSystem.colors.danger
        case .unknown:
            return DesignSystem.colors.warning
        }
    }
}

public struct CharacterStatusTag: View {
    let status: CharacterStatus
    
    public init(status: CharacterStatus) {
        self.status = status
    }
    
   public var body: some View {
        VStack {
            Text(status.rawValue)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .foregroundColor(.white)
                .font(Font.fredoka(weight: .semiBold, size: 16))
        }
        .background(status.getBackgroundColor())
        .cornerRadius(8)
    }
}

#Preview {
    CharacterStatusTag(status: .alive)
}
