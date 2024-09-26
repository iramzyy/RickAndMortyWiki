//
//  KeychainStorage.swift
//  StorageKit
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import Foundation
import KeychainSwift

public class KeychainStorage: Storage {
    public static let shared = KeychainStorage()
    
    private let keychain: KeychainSwift
    
    public init(keychain: KeychainSwift = KeychainSwift()) {
        self.keychain = keychain
    }
    
    public func fetch<T: Storable>(for key: String) -> T? {
        guard let data = keychain.getData(key) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    public func save<T: Storable>(_ value: T?, for key: String) {
        if let data = try? JSONEncoder().encode(value) {
            keychain.set(data, forKey: key)
        } else {
            keychain.delete(key)
        }
    }
    
    public func remove(for key: String) {
        keychain.delete(key)
    }
}
