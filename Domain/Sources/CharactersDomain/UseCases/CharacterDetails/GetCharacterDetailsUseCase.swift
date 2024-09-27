//
//  GetCharacterDetailsUseCase.swift
//  Domain
//
//  Created by Ahmed Ramzy on 27/09/2024.
//

import Foundation

public protocol GetCharacterDetailsUseCaseProtocol {
    func execute(
        input: GetCharacterDetailUseCaseInput
    ) async -> Result<CharacterDetails, CharacterError>
}

public struct GetCharacterDetailsUseCase: GetCharacterDetailsUseCaseProtocol {
    private let repo: CharactersRepoProtocol
    public init(repo: CharactersRepoProtocol) {
        self.repo = repo
    }

    public func execute(
        input: GetCharacterDetailUseCaseInput
    ) async -> Result<CharacterDetails, CharacterError> {
        await repo.getDetails(input)
    }
}
