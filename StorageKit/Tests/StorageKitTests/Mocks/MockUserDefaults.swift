//
//  MockUserDefaults.swift
//  StorageKit
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import Foundation

class MockUserDefaults: UserDefaults {
    var mockData: Data?
    var setDataCalled = false
    var removeObjectCalled = false
    
    override func data(forKey defaultName: String) -> Data? {
        return mockData
    }
    
    override func set(_ value: Any?, forKey defaultName: String) {
        setDataCalled = true
    }
    
    override func removeObject(forKey defaultName: String) {
        removeObjectCalled = true
    }
}
