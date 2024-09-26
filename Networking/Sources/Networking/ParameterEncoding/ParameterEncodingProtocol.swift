//
//  ParameterEncodingProtocol.swift
//  Networking
//
//  Created by Ahmed Ramzy on 26/09/2024.
//


import Foundation

public protocol ParameterEncodingProtocol {
    func encode(urlRequest: inout URLRequest, with parameters: NetworkHTTPParameters) throws
}
