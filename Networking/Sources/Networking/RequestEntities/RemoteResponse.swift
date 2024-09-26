//
//  RemoteResponse.swift
//  Networking
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import Foundation

public struct RemoteResponse<T, E: Decodable> {
    public let source: RemoteEndpoint
    public var urlResponse: URLResponse
    public var data: Data?
    public let result: Result<T, NetworkRequestError<E>>

    public init(
        source: RemoteEndpoint,
        urlResponse: URLResponse,
        data: Data? = nil,
        result: Result<T, NetworkRequestError<E>>
    ) {
        self.source = source
        self.urlResponse = urlResponse
        self.data = data
        self.result = result
    }
}
