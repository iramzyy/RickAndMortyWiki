//
//  Untitled.swift
//  Data
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import Foundation
import CoreDomain
import CharactersDomain

extension CharacterDetails: DecodableFromDTO {
    public struct DTO: Codable {
        var id: Int?
        var name: String?
        var status: CharacterStatus?
        var species: String?
        var type: String?
        var gender: String?
        var origin, location: Location.DTO?
        var image: String?
        var episode: [String]?
        var url: String?
        var created: String?
    }

    public init(from dto: DTO) {
        let origin = dto.origin.map { Location(name: $0.name, url: $0.url) }
        let location = dto.location.map { Location(name: $0.name, url: $0.url) }

        self = CharacterDetails(
            id: dto.id,
            name: dto.name,
            status: dto.status,
            species: dto.species,
            type: dto.type,
            gender: dto.gender,
            origin: origin,
            location: location,
            image: dto.image,
            episode: dto.episode,
            url: dto.url,
            created: dto.created
        )
    }
}

extension Location: DecodableFromDTO {
    public struct DTO: Codable {
        var name: String?
        var url: String?
    }

    public init(from dto: DTO) {
        self = Location(
            name: dto.name,
            url: dto.url
        )
    }
}
