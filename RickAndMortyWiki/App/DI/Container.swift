//
//  Container.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import Foundation
import Networking
import DataConfigurations
import CharactersDomain
import CharactersData

// MARK: - Container
class Container { }

// MARK: - Container + Network
extension Container: NetworkingConfigProtocol {
    static var networkManager: NetworkManagerProtocol {
        let remoteResponseHandler = NetworkResponseHandler(
          decoder: JSONDecoder(),
          encoder: JSONEncoder()
        )

        let networkManager = NetworkManager(
            responseHandler: remoteResponseHandler,
            authProvider: AuthManager.shared
          )

        return networkManager
    }
}

// MARK: - Container + UseCases
extension Container {
    static var getCharacterListUseCase: GetCharactersListUseCaseProtocol {
        return GetCharactersListUseCase(repo: DIContainer.charactersRepo)
    }

    static var getCharacterDetailsUseCase: GetCharacterDetailsUseCaseProtocol {
        return GetCharacterDetailsUseCase(repo: DIContainer.charactersRepo)
    }
}
