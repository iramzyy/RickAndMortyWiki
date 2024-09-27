//
//  RemoteImage.swift
//  DesignKit
//
//  Created by Ahmed Ramzy on 27/09/2024.
//


import SwiftUI

public struct RemoteImage: View {
    public let url: String
    public var placeholder: Image = Image(systemName: "exclamationmark.triangle")

    public init(url: String,
                placeholder: Image = Image(
                    systemName: "exclamationmark.triangle")) {
        self.url = url
        self.placeholder = placeholder
    }

    public var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .background(.clear)
            } else if phase.error != nil {
                placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(DesignSystem.colors.danger)
            } else {
                ProgressView()
            }
        }
    }
}

#Preview {
    RemoteImage(url: "https://cdn.wallpapersafari.com/17/54/nHGuAS.png")
}
