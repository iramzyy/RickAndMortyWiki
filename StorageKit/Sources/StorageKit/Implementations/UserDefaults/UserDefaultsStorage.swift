//
//  UserDefaultsStorage.swift
//  StorageKit
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import Foundation

public class UserDefaultsStorage: Storage {
    public static let shared = UserDefaultsStorage()
    
    private let defaults: UserDefaults
    
    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    public func fetch<T: Storable>(for key: String) -> T? {
        guard let data = defaults.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    public func save<T: Storable>(_ value: T?, for key: String) {
        let data = try? JSONEncoder().encode(value)
        defaults.set(data, forKey: key)
    }
    
    public func remove(for key: String) {
        defaults.removeObject(forKey: key)
    }
}
