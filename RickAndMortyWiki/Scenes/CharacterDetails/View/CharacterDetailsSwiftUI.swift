//
//  CharacterDetailsSwiftUI.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import Core
import DesignKit
import SwiftUI

struct CharacterDetailsSwiftUI: View {
    var viewModel: CharacterDetailsViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            RemoteImage(url: viewModel.character?.image ?? "")
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .ignoresSafeArea(edges: .top)
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(viewModel.character?.name ?? "")
                        .font(Font.fredoka(weight: .bold, size: 20))
                    Spacer()
                    CharacterStatusTag(status: CharacterStatus(rawValue: (viewModel.character?.status.rawValue ?? "")) ?? .alive)
                }
                
                HStack {
                    Text(viewModel.character?.species ?? "")
                        .font(Font.fredoka(weight: .regular, size: 16))
                    Text("•")
                    Text(viewModel.character?.gender ?? "")
                        .font(Font.fredoka(weight: .regular, size: 16))
                }
                
                Text("Location : \(viewModel.character?.location ?? "")")
                    .font(Font.fredoka(weight: .regular, size: 14))
                
            }.padding()
            
            Spacer()
        }
    }
}

#Preview {
    CharacterDetailsSwiftUI(viewModel: CharacterDetailsViewModel(useCase: Container.getCharacterDetailsUseCase,
                                                                 characterID: 13,
                                                                 callback: { type in
                                                                     switch type {
                                                                     case .back:
                                                                         break
                                                                     }
                                                                 }))
}
