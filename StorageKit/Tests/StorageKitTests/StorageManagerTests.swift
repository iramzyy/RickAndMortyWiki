//
//  StorageManagerTests.swift
//  StorageKit
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import XCTest
@testable import StorageKit

class StorageManagerTests: XCTestCase {
    var manager: StorageManager!
    var mockFactory: MockStorageFactory!
    
    override func setUp() {
        super.setUp()
        mockFactory = MockStorageFactory()
        manager = StorageManager(factory: mockFactory)
    }
    
    func testFetch() {
        let key = StorageKey<String>("testKey", storageType: .userDefaults)
        _ = manager.fetch(for: key)
        XCTAssertTrue(mockFactory.mockStorage.fetchCalled)
    }
    
    func testSave() {
        let key = StorageKey<String>("testKey", storageType: .userDefaults)
        manager.save("testValue", for: key)
        XCTAssertTrue(mockFactory.mockStorage.saveCalled)
    }
    
    func testRemove() {
        let key = StorageKey<String>("testKey", storageType: .userDefaults)
        manager.remove(for: key)
        XCTAssertTrue(mockFactory.mockStorage.removeCalled)
    }
}
