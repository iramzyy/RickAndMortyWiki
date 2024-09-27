//
//  GetCharacterListUseCaseInput.swift
//  Domain
//
//  Created by Ahmed Ramzy on 27/09/2024.
//

import Foundation


public protocol Pagable {
    var page: Int { get set }
}

public protocol GetCharactersListUseCaseInputProtocol: Pagable { }


public struct GetCharactersListUseCaseInput: GetCharactersListUseCaseInputProtocol {
    public var page: Int
    public var status: CharacterStatus?
    
    public init(page: Int = 1, status: CharacterStatus? = nil) {
        self.page = page
        self.status = status
    }
}
