//
//  AppDelegateConfigurable.swift
//  Core
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import Foundation

public protocol Configurable {
    func configure()
}

public protocol AppDelegateConfigurable: Configurable {
    static var shared: AppDelegateConfigurable { get }
}

public  extension AppDelegateConfigurable {
    func configure() {}
}
