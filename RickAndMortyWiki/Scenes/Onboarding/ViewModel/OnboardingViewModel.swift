//
//  OnboardingViewModel.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import Foundation
import Combine

enum OnboardingViewModelCallbackType {
    case start
    
}

typealias OnboardingViewModelCallback = ((OnboardingViewModelCallbackType) -> Void)

class OnboardingViewModel: ObservableObject {
    
    var callback: OnboardingViewModelCallback
    
    init(callback: @escaping OnboardingViewModelCallback) {
        self.callback = callback
    }
    
    
    func navigateToCharactersListing() {
        callback(.start)
    }
}
