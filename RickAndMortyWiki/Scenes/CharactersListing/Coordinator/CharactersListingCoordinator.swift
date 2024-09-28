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
    
    required init(useCase: CharactersListingCoordinatorUseCaseProtocol) {
        self.useCase = useCase
        window = useCase.window
        viewModel = CharactersListViewModel(useCase: Container.getCharacterListUseCase,
                                            callback: processViewModelCallback())
    }
    
    func start() {
        let initialViewController = CharactersListViewController(viewModel: viewModel!)
        let navigationController = UINavigationController(rootViewController: initialViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}


private extension CharactersListingCoordinator {
    func processViewModelCallback() -> CharactersListViewModelCallback {
        return { [weak self] type in
            switch type {
            case let .details(id):
                print("Id = \(id)")
            }
        }
    }
}
