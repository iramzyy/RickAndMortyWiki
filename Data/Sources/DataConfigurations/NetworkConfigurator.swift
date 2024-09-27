//
//  NetworkConfigurator.swift
//  Data
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import Foundation
import Networking

public final class NetworkConfigurator {
    static var shared: NetworkConfigurator?

    public let networkManager: NetworkManagerProtocol

    fileprivate init(_ config: NetworkingConfigProtocol.Type) {
        self.networkManager = config.networkManager
    }
}

public protocol NetworkingConfigProtocol {
    static var networkManager: NetworkManagerProtocol { get }
}

public func setup(networkingConfig config: NetworkingConfigProtocol.Type) {
    NetworkConfigurator.shared = NetworkConfigurator(config)
}

public var networkConfig: NetworkConfigurator {
    if let config = NetworkConfigurator.shared {
        return config
    } else {
        fatalError("Please set the Config for \(Bundle(for: NetworkConfigurator.self))")
    }
}
