//
//  EndpointType.swift
//  Networking
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import Foundation

public enum EndpointType: Equatable {
    case server
    case localFile(bundle: Bundle, fileName: String)
}
