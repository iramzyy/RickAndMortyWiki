//
//  Config.swift
//  Networking
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import Foundation

public protocol Config {
    var reachabilityManager: ReachabilityProtocol { get }
}

private(set) var config: Config?

public func setup(with newConfig: Config) {
    config = newConfig
}
