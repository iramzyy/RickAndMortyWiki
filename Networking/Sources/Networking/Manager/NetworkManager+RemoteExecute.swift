//
//  NetworkManager+RemoteExecute.swift
//  Networking
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import Combine
import Foundation

public struct NetworkManager: NetworkManagerProtocol {
    private let sessionConfiguration: URLSessionConfiguration
    var responseHandler: ResponseHandler
    private let authProvider: AuthTokenProviderProtocol?

    public init(
        sessionConfiguration: URLSessionConfiguration = .default,
        responseHandler: ResponseHandler,
        authProvider: AuthTokenProviderProtocol?
    ) {
        self.sessionConfiguration = sessionConfiguration
        self.responseHandler = responseHandler
        self.authProvider = authProvider
    }

    public func executeRequest<T: Decodable, E: Decodable>(
        _ endpoint: RemoteEndpoint,
        appErrors: [any AppErrorProtocol]? = nil
    ) async -> RemoteResponse<T, E> where E: Decodable, E: Decodable {
        switch endpoint.type {
        case .server:
            let isConnected = config?.reachabilityManager.isConnected ?? true

            let urlRequest: URLRequest
            let remoteResponse: RemoteResponse<T, E>

            do {
                let requestFactory = NetworkRequestFactory<E>(
                    authProvider: authProvider,
                    encoder: responseHandler.encoder
                )
                urlRequest = try requestFactory.generateRequest(
                    isConnected: isConnected, endpoint: endpoint
                )
            } catch {
                // failed to create request
                remoteResponse = getError(source: endpoint, error: .failure(reason: .badRequest))
                return remoteResponse
            }

            guard let requestSessionConfig = sessionConfiguration.copy() as? URLSessionConfiguration else {
                let remoteResponse: RemoteResponse<T, E> = getError(source: endpoint,
                                                                    error: .failure(reason: .urlNotFound))
                return remoteResponse
            }

            requestSessionConfig.waitsForConnectivity = endpoint.waitsForInternetConnection
            let session = URLSession(configuration: requestSessionConfig)
            do {
                let (data, response) = try await session.data(for: urlRequest)
                remoteResponse = getSuccess(source: endpoint,
                                            data: data,
                                            response: response,
                                            appErrors: appErrors)
            } catch {
                remoteResponse = getError(source: endpoint, error: .failure(reason: .invalidError))
            }

            return remoteResponse
        case let .localFile(bundle, fileName):
            return getLocalResponse(
                source: endpoint,
                bundle: bundle,
                fileName: fileName,
                appErrors: appErrors)
        }
    }
}
