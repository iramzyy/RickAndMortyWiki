//
//  CharactersRepoFailureMock.swift
//  Domain
//
//  Created by Ahmed Ramzy on 27/09/2024.
//

import Foundation
@testable import CoreDomain
@testable import CharactersDomain

struct CharactersRepoFailureMock: CharactersRepoProtocol {
    func getListing(_ input: GetCharactersListRepoInput
    ) async -> Result<CharactersList, CharacterError> {
        .failure(.unknown)
    }

    func getDetails(_ input: GetCharacterDetailRepoInput
    ) async -> Result<CharacterDetails, CharacterError> {
        .failure(.unknown)
    }
}
