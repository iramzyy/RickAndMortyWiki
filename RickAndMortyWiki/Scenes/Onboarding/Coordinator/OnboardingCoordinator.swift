//
//  OnboardingCoordinator.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import Foundation
import UIKit

protocol OnboardingCoordinatorUseCaseProtocol {
    var window: UIWindow? { get set }
}

protocol OnboardingCoordinatorProtocol {
    init(useCase: OnboardingCoordinatorUseCaseProtocol)
    func start()
}

class OnboardingCoordinator: OnboardingCoordinatorProtocol {
    let useCase: OnboardingCoordinatorUseCaseProtocol
    private let window: UIWindow?
    private var viewModel: OnboardingViewModel?
    
    required init(useCase: OnboardingCoordinatorUseCaseProtocol) {
        self.useCase = useCase
        window = useCase.window
        viewModel = OnboardingViewModel(callback: processViewModelCallback())
    }

    func start() {
        let initialViewController = OnboardingViewController(viewModel: viewModel!)
        let navigationController = UINavigationController(rootViewController: initialViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    private func processViewModelCallback() -> OnboardingViewModelCallback {
        return { [unowned self] type in
            switch type {
            case .start:
                self.navigateToCharactersList()
            }
        }
    }
    
    private func navigateToCharactersList() {
        struct UseCase: CharactersListingCoordinatorUseCaseProtocol {
            var window: UIWindow?
        }

        guard let window = self.window else {
            print("Window is Nil")
            return
        }
          
        let coordinator = CharactersListingCoordinator(useCase: UseCase(window: window))
        coordinator.start()
    }
}
