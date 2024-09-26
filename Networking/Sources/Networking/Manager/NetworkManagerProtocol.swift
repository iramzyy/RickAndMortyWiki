//
//  NetworkManagerProtocol.swift
//  Networking
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import Combine

public protocol NetworkManagerProtocol {
    func executeRequest<T: Decodable, E: Decodable>(
        _ endpoint: any RemoteEndpoint,
        appErrors: [any AppErrorProtocol]?
    ) async -> RemoteResponse<T, E>
}
