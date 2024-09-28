//
//  SwiftUIView.swift
//  DesignKit
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import SwiftUI

public struct GridView: View {
    public var items: [String]
    @Binding public var selectedItem: String?

    public init(items: [String], selectedItem: Binding<String?>) {
        self.items = items
        self._selectedItem = selectedItem
    }

    let columns = [
        GridItem(.flexible(), spacing: 8)
    ]

    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: columns, spacing: 8) {
                ForEach(items, id: \.self) { filter in
                    GridViewItem(isSelected: Binding(
                        get: { selectedItem == filter },
                        set: { isSelected in
                            selectedItem = isSelected ? filter : nil
                        }
                    ), text: filter)
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 50)
    }
}

#Preview {
    GridView(items: ["Alive", "Dead", "Unknown"], selectedItem: .constant("Alive"))
}
