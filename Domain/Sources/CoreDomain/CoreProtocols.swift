//
//  CoreProtocols.swift
//  Domain
//
//  Created by Ahmed Ramzy on 27/09/2024.
//

import Foundation

/// Base protocol for all application errors
public protocol AppErrorProtocol: Error {}

/// Base protocol for all application repsonse
public protocol AppResponseProtocol {}

/// Base usecase protocol
protocol UseCase {
    associatedtype Input
    associatedtype ReturnType
    associatedtype ReturnErrorType: Error

    func execute(_ input: Input) async -> Result<ReturnType, ReturnErrorType>
}

public protocol DecodableFromDTO {
    associatedtype DTO: Decodable
    init(from dto: DTO)
}
