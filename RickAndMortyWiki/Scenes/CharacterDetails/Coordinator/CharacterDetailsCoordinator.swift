//
//  CharacterDetailsCoordinator.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import UIKit
import SwiftUI

protocol CharacterDetailsCoordinatorUseCaseProtocol {
    var navigationController: UINavigationController? { get set }
    var characterId: Int { get set }
}
protocol CharacterDetailCoordinatorProtocol {
    init(useCase: CharacterDetailsCoordinatorUseCaseProtocol)
    func start()

}

struct CharacterDetailsCoordinatorUseCase: CharacterDetailsCoordinatorUseCaseProtocol {
    var navigationController: UINavigationController?
    var characterId: Int
}

class CharacterDetailsCoordinator: CharacterDetailCoordinatorProtocol {
    private let useCase: CharacterDetailsCoordinatorUseCaseProtocol
    private var viewModel: CharacterDetailsViewModel?

    required init(useCase: CharacterDetailsCoordinatorUseCaseProtocol) {
        self.useCase = useCase
    }

    func start() {
        viewModel = CharacterDetailsViewModel(
            useCase: Container.getCharacterDetailsUseCase,
            characterID: useCase.characterId,
            callback: processViewModelCallback()
        )

        let viewController = CharacterDetailsViewController(viewModel: viewModel!)
        useCase.navigationController?.pushViewController(viewController, animated: true)
    }

    private func processViewModelCallback() -> CharacterDetailsViewModelCallback {
        return { [weak self] type in
            switch type {
            case .back:
                self?.useCase.navigationController?.popViewController(animated: true)
            }
        }
    }
}
