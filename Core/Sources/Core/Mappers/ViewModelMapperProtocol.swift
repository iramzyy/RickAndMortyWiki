//
//  ViewModelMapperProtocol.swift
//  Core
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

import Foundation

/**
Use this protocol to add mapping in your view model from domain model to view model
 */
public protocol ViewModelMapperProtocol {
    associatedtype InputProtocol
    associatedtype OutputProtocol

    func map(domain: InputProtocol) -> OutputProtocol
}
