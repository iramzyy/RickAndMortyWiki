//
//  CharactersListResponseMock.swift
//  Domain
//
//  Created by Ahmed Ramzy on 27/09/2024.
//

@testable import CoreDomain
import Foundation
@testable import CharactersDomain

var pageInfo = Info(count: 100, pages: 10, next: "", prev: "")
var charactersListSuccessResponseMock = CharactersList(
    info: pageInfo,
    results: [
        CharacterDetails(
            id: 1,
            name: "Character name #1",
            status: .alive,
            species: "Character species #1",
            type: "Character type #1",
            gender: "Character gender #1",
            origin: nil,
            location: nil,
            image: "image1.png",
            episode: [],
            url: "",
            created: ""
        ),
        CharacterDetails(
            id: 2,
            name: "Character name #2",
            status: .dead,
            species: "Character species #2",
            type: "Character type #2",
            gender: "Character gender #2",
            origin: nil,
            location: nil,
            image: "image2.png",
            episode: [],
            url: "",
            created: ""
        ),
        CharacterDetails(
            id: 3,
            name: "Character name #3",
            status: .unknown,
            species: "Character species #3",
            type: "Character type #3",
            gender: "Character gender #3",
            origin: nil,
            location: nil,
            image: "image1.png",
            episode: [],
            url: "",
            created: ""
        )
    ]
)
var charactersDetailSuccessResponseMock =  CharacterDetails(
    id: 1,
    name: "Character name #1",
    status: .alive,
    species: "Character species #1",
    type: "Character type #1",
    gender: "Character gender #1",
    origin: nil,
    location: nil,
    image: "image1.png",
    episode: [],
    url: "",
    created: ""
)
