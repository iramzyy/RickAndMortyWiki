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
    private var navigationController: UINavigationController?
    private var childCoordinators: [Any] = []
    
    required init(useCase: OnboardingCoordinatorUseCaseProtocol) {
        self.useCase = useCase
        window = useCase.window
        viewModel = OnboardingViewModel(callback: processViewModelCallback())
    }

    func start() {
        let initialViewController = OnboardingViewController(viewModel: viewModel!)
        navigationController = UINavigationController(rootViewController: initialViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    private func processViewModelCallback() -> OnboardingViewModelCallback {
        return { [weak self] type in
            switch type {
            case .start:
                self?.navigateToCharactersList()
            }
        }
    }
    
    private func navigateToCharactersList() {
        guard let window = self.window else {
            print("Window is nil")
            return
        }
        
        let useCase = CharactersListingCoordinatorUseCase(window: window)
        let coordinator = CharactersListingCoordinator(useCase: useCase)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

struct CharactersListingCoordinatorUseCase: CharactersListingCoordinatorUseCaseProtocol {
    var window: UIWindow?
}
