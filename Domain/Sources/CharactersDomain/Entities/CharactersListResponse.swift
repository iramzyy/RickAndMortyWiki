//
//  CharactersListResponse.swift
//  Domain
//
//  Created by Ahmed Ramzy on 27/09/2024.
//

import Foundation

// MARK: - Characters List
public struct CharactersList: Codable {
    public var info: Info?
    public var results: [CharacterDetails]

    public init(info: Info,
                results: [CharacterDetails]) {
        self.info = info
        self.results = results
    }
}

// MARK: - Pagination Info
public struct Info: Codable {
    public let count, pages: Int?
    public let next: String?
    public let prev: String?

    public init(count: Int?,
        pages: Int?,
        next: String?,
        prev: String?) {
        self.count = count
        self.pages = pages
        self.next = next
        self.prev = prev
    }
}

// MARK: - Character Details
public struct CharacterDetails: Codable {
    public var id: Int?
    public var name: String?
    public var status: CharacterStatus?
    public var species: String?
    public var type: String?
    public  var gender: String?
    public var origin, location: Location?
    public var image: String?
    public var episode: [String]?
    public var url: String?
    public var created: String?

    public init(
        id: Int? = nil,
        name: String? = nil,
        status: CharacterStatus? = nil,
        species: String? = nil,
        type: String? = nil,
        gender: String? = nil,
        origin: Location? = nil,
        location: Location? = nil,
        image: String? = nil,
        episode: [String]? = nil,
        url: String? = nil,
        created: String? = nil
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }
}

// MARK: - Location
public struct Location: Codable {
    public var name: String?
    public var url: String?
    public init(
        name: String? = nil,
        url: String? = nil
    ) {
        self.name = name
        self.url = url
    }
}
// MARK: - CharacterStatus
public enum CharacterStatus: String, Codable, CaseIterable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
