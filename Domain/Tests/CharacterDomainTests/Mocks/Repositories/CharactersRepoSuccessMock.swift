//
//  CharactersRepoSuccessMock.swift
//  Domain
//
//  Created by Ahmed Ramzy on 27/09/2024.
//

import Foundation
@testable import CoreDomain
@testable import CharactersDomain

struct CharactersRepoSuccessMock: CharactersRepoProtocol {
    func getListing(_ input: GetCharactersListRepoInput
    ) async -> Result<CharactersList, CharacterError> {
        return .success(charactersListSuccessResponseMock)
    }

    func getDetails(_ input: GetCharacterDetailRepoInput
    ) async -> Result<CharacterDetails, CharacterError> {
        return .success(charactersDetailSuccessResponseMock)
    }
}
