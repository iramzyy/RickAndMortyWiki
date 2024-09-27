//
//  GetCharacterListUseCase.swift
//  Domain
//
//  Created by Ahmed Ramzy on 27/09/2024.
//

import Foundation

public protocol GetCharactersListUseCaseProtocol {
    func execute(
        input: GetCharactersListUseCaseInput
    ) async -> Result<CharactersList, CharacterError>
}

public struct GetCharactersListUseCase: GetCharactersListUseCaseProtocol {
    private let repo: CharactersRepoProtocol

    public init(repo: CharactersRepoProtocol) {
        self.repo = repo
    }

    public func execute(input: GetCharactersListUseCaseInput) async -> Result<CharactersList, CharacterError> {
        await repo.getListing(input)
    }
}
