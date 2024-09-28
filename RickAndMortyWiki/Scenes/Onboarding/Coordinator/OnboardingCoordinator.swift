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
    private var viewModel: OnboardingViewModelProtocol?
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
}

private extension OnboardingCoordinator {
    func processViewModelCallback() -> OnboardingViewModelCallback {
        return { [weak self] type in
            switch type {
            case .start:
                print("Start")
            }
        }
    }
}
