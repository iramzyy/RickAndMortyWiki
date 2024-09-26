//
//  StorageKeyTests.swift
//  StorageKit
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import XCTest
@testable import StorageKit

class StorageKeyTests: XCTestCase {
    func testStorageKeyInitialization() {
        let key = StorageKey<String>("testKey", storageType: .userDefaults)
        XCTAssertEqual(key.key, "testKey")
        XCTAssertEqual(key.storageType, .userDefaults)
    }
}
