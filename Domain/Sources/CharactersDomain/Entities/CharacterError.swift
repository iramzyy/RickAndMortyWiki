//
//  CharacterError.swift
//  Domain
//
//  Created by Ahmed Ramzy on 27/09/2024.
//

import Foundation
import CoreDomain

public enum CharacterError: AppErrorProtocol {
    case encoding
    case error(message: String)
    case unknown
}
