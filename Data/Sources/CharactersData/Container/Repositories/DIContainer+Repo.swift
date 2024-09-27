//
//  DIContainer+Repo.swift
//  Data
//
//  Created by Ahmed Ramzy on 28/09/2024.
//


import Foundation
import DataConfigurations
import CharactersDomain

public extension DIContainer {
    static var charactersRepo: CharactersRepoProtocol {
        return CharactersRepository(remoteDataSource: remoteCharacterDataSource)
    }
}
