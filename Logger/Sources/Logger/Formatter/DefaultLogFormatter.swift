//
//  DefaultLogFormatter.swift
//  Logger
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

public class DefaultLogFormatter: LogFormatter {
    public init() {}
    
    public func format(_ entry: LogEntry) -> String {
        let emoji: String
        switch entry.level {
        case .info: emoji = "ℹ️"
        case .warn: emoji = "⚠️"
        case .error: emoji = "🔴"
        }
        
        return """
        \(emoji)
        Message: \(entry.message)
        File: \(entry.file)
        Function: \(entry.function)
        Line: \(entry.line)
        \(emoji)
        """
    }
}
