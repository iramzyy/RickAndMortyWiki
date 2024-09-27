//
//  CharactersRepo.swift
//  Domain
//
//  Created by Ahmed Ramzy on 27/09/2024.
//

import Foundation
import CoreDomain

public typealias GetCharactersListRepoInput = GetCharactersListUseCaseInput
public typealias GetCharacterDetailRepoInput = GetCharacterDetailUseCaseInput

public protocol CharactersRepoProtocol {
    func getListing(_ input: GetCharactersListRepoInput
    ) async -> Result<CharactersList, CharacterError>

    func getDetails(_ input: GetCharacterDetailRepoInput
    ) async -> Result<CharacterDetails, CharacterError>
}
