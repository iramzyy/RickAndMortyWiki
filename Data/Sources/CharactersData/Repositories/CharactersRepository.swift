//
//  CharactersRepository.swift
//  Data
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import Foundation
import CoreDomain
import CharactersDomain

public struct CharactersRepository: CharactersRepoProtocol {
    private let remoteDataSource: RemoteCharactersDataSourceProtocol

    public init(remoteDataSource: RemoteCharactersDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }

    public func getListing(
        _ input: GetCharactersListRepoInput
    ) async -> Result<CharactersList, CharacterError> {
        await remoteDataSource.getListing(input)
    }

    public func getDetails(
        _ input: GetCharacterDetailRepoInput
    ) async -> Result<CharacterDetails, CharacterError> {
        await remoteDataSource.getDetails(input)
    }
}
