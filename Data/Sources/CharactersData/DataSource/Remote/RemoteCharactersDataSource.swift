//
//  RemoteCharactersDataSource.swift
//  Data
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import Foundation
import CharactersDomain
import Networking


public protocol RemoteCharactersDataSourceProtocol {
    func getListing(
        _ input: GetCharactersListRepoInput
    ) async -> Result<CharactersList, CharacterError>

    func getDetails(
        _ input: GetCharacterDetailRepoInput
    ) async -> Result<CharacterDetails, CharacterError>
}


public struct RemoteCharacterDataSource: RemoteCharactersDataSourceProtocol {
    private let networkingManger: NetworkManagerProtocol

    public init(networkingManger: NetworkManagerProtocol) {
        self.networkingManger = networkingManger
    }


    public func getListing(
        _ input: GetCharactersListRepoInput
    ) async -> Result<CharactersList, CharacterError> {
        let endpoint = CharactersEndpoint.listing(page: input.page, status: input.status)
        let result: Result<CharactersList.DTO, NetworkRequestError<CharacterError.DTO>>
        result = await networkingManger.executeRequest(endpoint, appErrors: nil).result

        switch result {
        case let .success(dto):
            return .success(CharactersList(from: dto))
        case let .failure(error):
            switch error {
            case let .appError(dto):
                return .failure(CharacterError(from: dto))
            case .failure:
                return .failure(CharacterError.unknown)
            }
        }
    }


    public func getDetails(
        _ input: GetCharacterDetailRepoInput
    ) async -> Result<CharacterDetails, CharacterError> {
        let endpoint = CharactersEndpoint.details(id: input.id)
        let result: Result<CharacterDetails.DTO, NetworkRequestError<CharacterError.DTO>>
        result = await networkingManger.executeRequest(endpoint, appErrors: nil).result

        switch result {
        case let .success(dto):
            return .success(CharacterDetails(from: dto))
        case let .failure(error):
            switch error {
            case let .appError(dto):
                return .failure(CharacterError(from: dto))
            case .failure:
                return .failure(CharacterError.unknown)
            }
        }
    }
}
