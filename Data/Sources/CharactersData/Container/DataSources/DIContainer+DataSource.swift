//
//  DIContainer+DataSource.swift
//  Data
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import Foundation
import DataConfigurations
import CharactersDomain

public extension DIContainer {
    static var remoteCharacterDataSource: RemoteCharactersDataSourceProtocol {
        return RemoteCharacterDataSource(networkingManger: networkConfig.networkManager)
    }
}
