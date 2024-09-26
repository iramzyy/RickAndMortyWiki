//
//  Logger.swift
//  Logger
//
//  Created by Ahmed Ramzy on 26/09/2024.
//

public class Logger: LoggingUseCase {
    private let formatter: LogFormatter
    private let destinations: [LogDestination]
    
    public init(formatter: LogFormatter,
                destinations: [LogDestination]) {
        self.formatter = formatter
        self.destinations = destinations
    }
    
    public func log(_ entry: LogEntry) {
        let formattedLog = formatter.format(entry)
        destinations.forEach { $0.write(formattedLog) }
    }
}

public extension Logger {
    func info(_ message: String,
        metadata: [String: Encodable]? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line) {
        let entry = LogEntry(
            level: .info,
            message: message,
            metadata: metadata,
            file: file,
            function: function,
            line: line
        )
        log(
            entry
        )
    }
    
    func warn(_ message: String,
        metadata: [String: Encodable]? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line) {
        let entry = LogEntry(
            level: .warn,
            message: message,
            metadata: metadata,
            file: file,
            function: function,
            line: line
        )
        log(
            entry
        )
    }
    
    func error(_ message: String,
        metadata: [String: Encodable]? = nil,
        error: Error? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line) {
        let entry = LogEntry(
            level: .error,
            message: message,
            metadata: metadata,
            error: error,
            file: file,
            function: function,
            line: line
        )
        log(
            entry
        )
    }
}
