//
//  CharactersListing+DTO.swift
//  Data
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import Foundation
import CoreDomain
import CharactersDomain

extension CharactersList: DecodableFromDTO {
    public struct DTO: Codable {
        let info: Info.DTO
        let results: [CharacterDetails.DTO]

        enum CodingKeys: String, CodingKey {
            case info, results
        }
    }
    public init(from dto: DTO) {
        let items = dto.results.map {
            CharacterDetails(from: $0)
        }

        let info = Info(from: dto.info)

        self = CharactersList(
            info: info,
            results: items
        )
    }
}

extension Info: DecodableFromDTO {
    public struct DTO: Codable {
        var count, pages: Int?
        var next: String?
        var prev: String?
    }
    public init(from dto: DTO) {
        self = Info(
            count: dto.count,
            pages: dto.pages,
            next: dto.next,
            prev: dto.prev
        )
    }
}
