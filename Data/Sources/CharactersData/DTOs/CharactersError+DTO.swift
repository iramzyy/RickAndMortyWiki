//
//  CharacterError+DTO.swift
//  Data
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import CoreDomain
import CharactersDomain
import Networking

extension CharacterError: DecodableFromDTO {
    public struct DTO: Codable {
        public var message: String?

        enum CodingKeys: String, CodingKey {
            case message = "status_message"
        }
    }

    public init(from dto: DTO) {
        self = .error(message: dto.message ?? "")
    }
}
