//
//  DataConfigurator.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//


import DataConfigurations
import Core
import Foundation

class DataConfigurator: AppDelegateConfigurable {
    static var shared: AppDelegateConfigurable = DataConfigurator()

    func configure() {
        DataConfigurations.setup(apiConfig: EndpointConfigurtions.self)
        DataConfigurations.setup(networkingConfig: Container.self)
    }
}
