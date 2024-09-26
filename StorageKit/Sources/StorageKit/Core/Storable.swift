//
//  Storable.swift
//  StorageKit
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import Foundation

public protocol Storable: Codable {}

public protocol Storage {
    func fetch<T: Storable>(for key: String) -> T?
    func save<T: Storable>(_ value: T?, for key: String)
    func remove(for key: String)
}
