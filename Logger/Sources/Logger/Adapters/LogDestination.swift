//
//  LogDestination.swift
//  Logger
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

public protocol LogDestination {
    func write(_ formattedLog: String)
}
