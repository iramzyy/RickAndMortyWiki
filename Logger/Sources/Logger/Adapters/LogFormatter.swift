//
//  LogFormatter.swift
//  Logger
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

public protocol LogFormatter {
    func format(_ entry: LogEntry) -> String
}
