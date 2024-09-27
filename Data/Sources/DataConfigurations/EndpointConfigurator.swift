//
//  EndpointConfigurator.swift
//  Data
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import Foundation

public final class EndpointConfigurator {
    static var shared: EndpointConfigurator?

    public let baseURL: URL
    public let apiVersion: String?
    fileprivate init(_ config: EndpointConfigurtionProtocol.Type) {
        self.baseURL = config.baseURL
        self.apiVersion = config.apiVersion
    }
}

public protocol EndpointConfigurtionProtocol {
    static var baseURL: URL { get }

    static var apiVersion: String? { get }
}

public extension EndpointConfigurtionProtocol {
    static var apiVersion: String? { nil }
}

public func setup(apiConfig config: EndpointConfigurtionProtocol.Type) {
    EndpointConfigurator.shared = EndpointConfigurator(config)
}

public var apiConfig: EndpointConfigurator {
    if let config = EndpointConfigurator.shared {
        return config
    } else {
        fatalError("Please set the Config for \(Bundle(for: EndpointConfigurator.self))")
    }
}
