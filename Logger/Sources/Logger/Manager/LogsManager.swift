//
//  KLogsManager.swift
//  Logger
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

public class LogsManager: LoggingUseCase {
    private let loggers: [LoggingUseCase]
    
    public init(loggers: [LoggingUseCase]) {
        self.loggers = loggers
    }
    
    public func log(_ entry: LogEntry) {
        loggers.forEach { $0.log(entry) }
    }
}

// Convenience methods for LogsManager
public extension LogsManager {
    func info(_ message: String, metadata: [String: Encodable]? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        let entry = LogEntry(level: .info, message: message, metadata: metadata, file: file, function: function, line: line)
        log(entry)
    }
    
    func warn(_ message: String, metadata: [String: Encodable]? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        let entry = LogEntry(level: .warn, message: message, metadata: metadata, file: file, function: function, line: line)
        log(entry)
    }
    
    func error(_ message: String, metadata: [String: Encodable]? = nil, error: Error? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        let entry = LogEntry(level: .error, message: message, metadata: metadata, error: error, file: file, function: function, line: line)
        log(entry)
    }
}
