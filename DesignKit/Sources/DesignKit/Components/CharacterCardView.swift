//
//  CharacterCardView.swift
//  DesignKit
//
//  Created by Ahmed Ramzy on 27/09/2024.
//

import SwiftUI

public struct CharacterCardView: View {
    let title: String
    let type: String
    let imageURL: String
    let status: String
    
    public init(title: String, type: String, imageURL: String, status: String) {
        self.title = title
        self.type = type
        self.imageURL = imageURL
        self.status = status
    }
    
    public var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 24) {
                RemoteImage(url: imageURL)
                    .frame(width: 100, height: 100)
                    .cornerRadius(8, corners: .allCorners)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(title)
                    Text(type)
                }
                Spacer()
            }
            .padding()
        }
        .overlay(
             RoundedRectangle(cornerRadius: 12)
                 .stroke(Color.gray.opacity(0.3), lineWidth: 1)
         )
         .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    CharacterCardView(title: "Rick Sanchez",
                      type: "Human",
                      imageURL: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                      status: "Alive")
}
