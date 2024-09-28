//
//  CharactersListingCoordinator.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import Foundation
import UIKit

protocol CharactersListingCoordinatorUseCaseProtocol {
    var window: UIWindow? { get set }
}

protocol CharactersListingCoordinatorProtocol {
    init(useCase: CharactersListingCoordinatorUseCaseProtocol)
    func start()
}

class CharactersListingCoordinator: CharactersListingCoordinatorProtocol {
    let useCase: CharactersListingCoordinatorUseCaseProtocol
    private let window: UIWindow?
    private var viewModel: CharactersListViewModel?
    private var childCoordinators: [Any] = []
    private var navigationController: UINavigationController?
    
    required init(useCase: CharactersListingCoordinatorUseCaseProtocol) {
        self.useCase = useCase
        window = useCase.window
        viewModel = CharactersListViewModel(useCase: Container.getCharacterListUseCase,
                                            callback: processViewModelCallback())
    }
    
    func start() {
        let initialViewController = CharactersListViewController(viewModel: viewModel!)
        navigationController = UINavigationController(rootViewController: initialViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func processViewModelCallback() -> CharactersListViewModelCallback {
        return { [weak self] type in
            switch type {
            case let .details(id):
                self?.navigateToCharacterDetails(id: id)
            }
        }
    }
    
    private func navigateToCharacterDetails(id: Int) {
        guard let navigationController = navigationController else { return }
        
        let useCase = CharacterDetailsCoordinatorUseCase(navigationController: navigationController,
                                                         characterId: id)
        let coordinator = CharacterDetailsCoordinator(useCase: useCase)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
