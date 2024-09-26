//
//  LogEntry.swift
//  Logger
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

public struct LogEntry {
    public let level: LogLevel
    public let message: String
    public let metadata: [String: Encodable]?
    public let error: Error?
    public let file: String
    public let function: String
    public let line: UInt
    
    public init(level: LogLevel,
        message: String,
        metadata: [String: Encodable]? = nil,
        error: Error? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line) {
        self.level = level
        self.message = message
        self.metadata = metadata
        self.error = error
        self.file = file
        self.function = function
        self.line = line
    }
}
