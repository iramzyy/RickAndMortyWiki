//
//  StorageManager.swift
//  StorageKit
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import Foundation

public class StorageManager {
    public static let shared = StorageManager()
    
    private let factory: StorageFactoryProtocol
    
    public init(factory: StorageFactoryProtocol = StorageFactory.shared) {
        self.factory = factory
    }
    
    public func fetch<T: Storable>(for key: StorageKey<T>) -> T? {
        let storage = factory.getStorage(for: key.storageType)
        return storage.fetch(for: key.key)
    }
    
    public func save<T: Storable>(_ value: T?, for key: StorageKey<T>) {
        let storage = factory.getStorage(for: key.storageType)
        storage.save(value, for: key.key)
    }
    
    public func remove<T: Storable>(for key: StorageKey<T>) {
        let storage = factory.getStorage(for: key.storageType)
        storage.remove(for: key.key)
    }
}
