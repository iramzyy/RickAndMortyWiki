//
//  StorageFactoryTests.swift
//  StorageKit
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import XCTest
@testable import StorageKit

class StorageFactoryTests: XCTestCase {
    func testGetStorageReturnsCorrectType() {
        let factory = StorageFactory.shared
        
        XCTAssertTrue(factory.getStorage(for: .userDefaults) is UserDefaultsStorage)
        XCTAssertTrue(factory.getStorage(for: .keychain) is KeychainStorage)
    }
}
