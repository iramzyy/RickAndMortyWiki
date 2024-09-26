//
//  StorageFactoryProtocol.swift
//  StorageKit
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import Foundation

public protocol StorageFactoryProtocol {
    func getStorage(for type: StorageType) -> Storage
}

public class StorageFactory: StorageFactoryProtocol {
    public static let shared = StorageFactory()
    
    private init() {}
    
    public func getStorage(for type: StorageType) -> Storage {
        switch type {
        case .userDefaults:
            return UserDefaultsStorage.shared
        case .keychain:
            return KeychainStorage.shared
        }
    }
}
