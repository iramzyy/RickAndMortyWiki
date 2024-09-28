//
//  GridViewItem.swift
//  DesignKit
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import SwiftUI

struct GridViewItem: View {
    @Binding public var isSelected: Bool
    public var text: String

    
    
    var body: some View {
        VStack {
            Text(text)
                .foregroundStyle(DesignSystem.colors.black)
                .font(Font.fredoka(weight: .regular, size: 14))
                .padding(8)
        }
        .background(isSelected ? .gray.opacity(0.2) : .clear)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(
                    isSelected ? .clear : .gray.opacity(0.4),
                    lineWidth: 1
                )
        )
        .onTapGesture {
            isSelected.toggle()
        }
    }
}

#Preview {
    GridViewItem(isSelected: .constant(false), text: "Grid Text")
}
