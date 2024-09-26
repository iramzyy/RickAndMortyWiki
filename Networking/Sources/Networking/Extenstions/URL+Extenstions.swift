//
//  URL+Extenstions.swift
//  Networking
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import Foundation

extension URL {
    mutating func appendQueryItems(_ newQueryItems: [URLQueryItem]) {
        guard var urlComponents = URLComponents(string: absoluteString) else { return }

        let existingQueryItems: [URLQueryItem] = urlComponents.queryItems ?? []

        urlComponents.queryItems = existingQueryItems + newQueryItems
        self = urlComponents.url!
    }
}
