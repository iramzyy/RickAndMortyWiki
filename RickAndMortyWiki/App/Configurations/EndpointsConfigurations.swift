//
//  EndpointsConfigurations.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import Foundation
import DataConfigurations

struct EndpointConfigurtions: EndpointConfigurtionProtocol {
    static var baseURL: URL {
        let baseURLString = "https://rickandmortyapi.com/api"
        let baseURL = URL(string: baseURLString)
        return baseURL ?? URL(string: "")!
    }
}
