//
//  CharacterModel.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import Foundation
import CharactersDomain

struct CharacterModel {
    var id: Int
    var name: String
    var species: String
    var location: String
    var gender: String
    var status: CharacterStatus
    var image: String
}
