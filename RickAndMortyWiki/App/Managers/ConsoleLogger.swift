//
//  LoggerManager.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import Foundation
import Core
import Logger

var consoleLogger: LogsManager {
    let defaultLogger = Logger(formatter: DefaultLogFormatter(),
                               destinations: [ConsoleLogDestination()])
    return LogsManager(loggers: [defaultLogger])
}

