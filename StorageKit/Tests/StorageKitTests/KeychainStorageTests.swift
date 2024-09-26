//
//  KeychainStorageTests.swift
//  StorageKit
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import XCTest
import KeychainSwift
@testable import StorageKit

class KeychainStorageTests: XCTestCase {
    var storage: KeychainStorage!
    var keychain: KeychainSwift!
    
    override func setUp() {
        super.setUp()
        // Create a KeychainSwift instance with a unique service name for isolation
        keychain = KeychainSwift(keyPrefix: "test_\(UUID().uuidString)_")
        storage = KeychainStorage(keychain: keychain)
    }
    
    override func tearDown() {
        // Clean up after each test
        keychain.clear()
        keychain = nil
        storage = nil
        super.tearDown()
    }
    
    func testSaveAndFetch() {
        let testString = "TestString"
        storage.save(testString, for: "testKey")
        
        let result: String? = storage.fetch(for: "testKey")
        XCTAssertEqual(result, testString)
    }
    
    func testRemove() {
        let testString = "TestString"
        storage.save(testString, for: "testKey")
        storage.remove(for: "testKey")
        
        let result: String? = storage.fetch(for: "testKey")
        XCTAssertNil(result)
    }
}
