//
//  MockStorage.swift
//  StorageKit
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

@testable import StorageKit

class MockStorage: Storage {
    var fetchCalled = false
    var saveCalled = false
    var removeCalled = false
    
    func fetch<T: Storable>(for key: String) -> T? {
        fetchCalled = true
        return nil
    }
    
    func save<T: Storable>(_ value: T?, for key: String) {
        saveCalled = true
    }
    
    func remove(for key: String) {
        removeCalled = true
    }
}
