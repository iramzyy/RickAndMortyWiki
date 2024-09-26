//
//  StorableExtensions.swift
//  StorageKit
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import Foundation

extension String: Storable {}
extension Int: Storable {}
extension Data: Storable {}
extension Float: Storable {}
extension Double: Storable {}
extension Date: Storable {}
extension Bool: Storable {}

extension Array: Storable where Element: Storable {}
