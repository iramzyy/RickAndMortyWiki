//
//  MockKeychainSwift.swift
//  StorageKit
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import KeychainSwift
@testable import StorageKit
import Foundation

class MockKeychainSwift: KeychainSwift {
    var mockData: Data?
    var setDataCalled = false
    var deleteCalled = false
    
    override func getData(_ key: String, asReference: Bool = false) -> Data? {
        return mockData
    }
    
    @discardableResult
    override func set(_ value: Data, forKey key: String, withAccess access: KeychainSwiftAccessOptions? = nil) -> Bool {
        setDataCalled = true
        return true
    }
    
    @discardableResult
    override func delete(_ key: String) -> Bool {
        deleteCalled = true
        return true
    }
}
