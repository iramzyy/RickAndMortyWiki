//
//  UserDefaultsStorageTests.swift
//  StorageKit
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import XCTest
@testable import StorageKit

class UserDefaultsStorageTests: XCTestCase {
    var storage: UserDefaultsStorage!
    var defaults: UserDefaults!
    
    override func setUp() {
        super.setUp()
        defaults = UserDefaults(suiteName: #file)
        storage = UserDefaultsStorage(defaults: defaults)
    }
    
    override func tearDown() {
        defaults.removePersistentDomain(forName: #file)
        defaults = nil
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
