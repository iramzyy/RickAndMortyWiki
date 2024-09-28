//
//  OnboardingSwiftUI.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import SwiftUI
import Core
import DesignKit

struct OnboardingSwiftUI: View {
    @ObservedObject var viewModel: OnboardingViewModel
    var body: some View {
        VStack {
            OnboardingView(pages: [
                OnboardingPage(title: "Explore Infinite Universes",
                               subtitle: "Dive deep into every episode, character, and planet in the multiverse.",
                               imageName: "RickNMorty-Logo"),
                OnboardingPage(title: "Secrets of the Multiverse",
                               subtitle: "Get detailed info on all your favorite characters, from Rick to the Meeseeks.",
                               imageName: "RickNMorty-Logo"),
                OnboardingPage(title: "Stay Updated",
                               subtitle: "Never miss out on the latest episodes and fan theories—keep the portal open!",
                               imageName: "RickNMorty-Logo")
            ])
            
            PrimaryButton(title: "Start") {
                viewModel.navigateToCharactersListing()
            }
            .padding()
        }
    }
}

#Preview {
    OnboardingSwiftUI(viewModel: OnboardingViewModel(callback: { type in
        switch type {
        case .start:
            break
        }
    }))
}
