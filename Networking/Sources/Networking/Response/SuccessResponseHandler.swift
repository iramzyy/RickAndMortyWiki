//
//  SuccessResponseHandler.swift
//  Networking
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import Foundation

public class SuccessResponseHandler: SuccessResponseHandlerProtocol {
    public var decoder: JSONDecoder

    public required init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }

    public func handle<T: Decodable, E: Decodable>(
        requestInfo: ResponseInfo
    )
        -> Result<T, NetworkRequestError<E>> {
        do {
            guard let data = requestInfo.data else {
                return .failure(.failure(reason: .noContent))
            }
            let responseModel = try decoder.decode(T.self, from: data)
            return .success(responseModel)
        } catch {
            return .failure(.failure(reason: .encodingFailed))
        }
    }
}
