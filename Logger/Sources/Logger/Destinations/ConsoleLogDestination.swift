//
//  ConsoleLogDestination.swift
//  Logger
//
//  Created by Ahmed Ramzy on 26/09/2024.
//


public class ConsoleLogDestination: LogDestination {
    public init() {}
    
    public func write(_ formattedLog: String) {
        debugPrint(formattedLog)
    }
}
