//
//  StorableExtensionsTests.swift
//  StorageKit
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import XCTest
@testable import StorageKit

class StorableExtensionsTests: XCTestCase {
    func testStringStorable() {
        let string: String = "Test"
        XCTAssertNoThrow(try JSONEncoder().encode(string))
    }
    
    func testIntStorable() {
        let int: Int = 42
        XCTAssertNoThrow(try JSONEncoder().encode(int))
    }
    
    func testDataStorable() {
        let data = Data([0, 1, 2, 3])
        XCTAssertNoThrow(try JSONEncoder().encode(data))
    }
    
    func testFloatStorable() {
        let float: Float = 3.14
        XCTAssertNoThrow(try JSONEncoder().encode(float))
    }
    
    func testDoubleStorable() {
        let double: Double = 3.14159
        XCTAssertNoThrow(try JSONEncoder().encode(double))
    }
    
    func testDateStorable() {
        let date = Date()
        XCTAssertNoThrow(try JSONEncoder().encode(date))
    }
    
    func testBoolStorable() {
        let bool: Bool = true
        XCTAssertNoThrow(try JSONEncoder().encode(bool))
    }
    
    func testArrayStorable() {
        let array: [Int] = [1, 2, 3, 4, 5]
        XCTAssertNoThrow(try JSONEncoder().encode(array))
    }
}
