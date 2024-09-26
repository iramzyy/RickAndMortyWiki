//
//  MockStorageFactory.swift
//  StorageKit
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

@testable import StorageKit

class MockStorageFactory: StorageFactoryProtocol {
    let mockStorage = MockStorage()
    
    func getStorage(for type: StorageType) -> Storage {
        return mockStorage
    }
}
