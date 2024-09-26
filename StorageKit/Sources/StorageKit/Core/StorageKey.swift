//
//  StorageKey.swift
//  StorageKit
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import Foundation

public struct StorageKey<T> {
    let key: String
    let storageType: StorageType

    public init(_ key: String,
                storageType: StorageType) {
        self.key = key
        self.storageType = storageType
    }
}
