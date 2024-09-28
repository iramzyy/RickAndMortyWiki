//
//  AppConfigurations.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import Foundation
import Logger
import DataConfigurations

struct AppConfig {
    var endpointConfigurtions: EndpointConfigurtions

    init?() {
        guard let endpointConfigurtions = Self.getAPiConfig() else {
            return nil
        }

        self.endpointConfigurtions = endpointConfigurtions
    }

    private static func getAPiConfig() -> EndpointConfigurtions? {
        return EndpointConfigurtions()
    }
}
