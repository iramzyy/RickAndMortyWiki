import XCTest
@testable import Logger

class LogEntryTests: XCTestCase {
    func testLogEntryInitialization() {
        let error = NSError(domain: "TestDomain", code: 1, userInfo: nil)
        let entry = LogEntry(level: .info,
                             message: "Test message",
                             metadata: ["key": "value"],
                             error: error,
                             file: "TestFile.swift",
                             function: "testFunction()",
                             line: 10)
        
        XCTAssertEqual(entry.level, .info)
        XCTAssertEqual(entry.message, "Test message")
        XCTAssertEqual(entry.metadata as? [String: String], ["key": "value"])
        XCTAssertEqual(entry.error as? NSError, error)
        XCTAssertEqual(entry.file, "TestFile.swift")
        XCTAssertEqual(entry.function, "testFunction()")
        XCTAssertEqual(entry.line, 10)
    }
}

// MARK: - LoggerTests

class LoggerTests: XCTestCase {
    class MockFormatter: LogFormatter {
        func format(_ entry: LogEntry) -> String {
            return "[\(entry.level)] \(entry.message)"
        }
    }
    
    class MockDestination: LogDestination {
        var lastWrittenLog: String?
        func write(_ formattedLog: String) {
            lastWrittenLog = formattedLog
        }
    }
    
    var logger: Logger!
    var mockFormatter: MockFormatter!
    var mockDestination: MockDestination!
    
    override func setUp() {
        super.setUp()
        mockFormatter = MockFormatter()
        mockDestination = MockDestination()
        logger = Logger(formatter: mockFormatter,
                        destinations: [mockDestination])
    }
    
    func testLoggerLogging() {
        let entry = LogEntry(level: .info,
                             message: "Test message")
        logger.log(entry)
        
        XCTAssertEqual(mockDestination.lastWrittenLog, "[info] Test message")
    }
}

// MARK: - LogsManagerTests

class LogsManagerTests: XCTestCase {
    class MockLogger: LoggingUseCase {
        var loggedEntries: [LogEntry] = []
        func log(_ entry: LogEntry) {
            loggedEntries.append(entry)
        }
    }
    
    var mockLogger1: MockLogger!
    var mockLogger2: MockLogger!
    var logsManager: LogsManager!
    
    override func setUp() {
        super.setUp()
        mockLogger1 = MockLogger()
        mockLogger2 = MockLogger()
        logsManager = LogsManager(loggers: [mockLogger1,
                                            mockLogger2])
    }
    
    func testLogDistribution() {
        let testEntry = LogEntry(level: .info,
                                 message: "Test message")
        logsManager.log(testEntry)
        
        XCTAssertEqual(mockLogger1.loggedEntries.count, 1)
        XCTAssertEqual(mockLogger2.loggedEntries.count, 1)
        XCTAssertEqual(mockLogger1.loggedEntries.first?.message, "Test message")
        XCTAssertEqual(mockLogger2.loggedEntries.first?.message, "Test message")
    }
    
    func testInfoLog() {
        logsManager.info("Info message",
                         metadata: ["key": "value"])
        
        XCTAssertEqual(mockLogger1.loggedEntries.count, 1)
        XCTAssertEqual(mockLogger2.loggedEntries.count, 1)
        XCTAssertEqual(mockLogger1.loggedEntries.first?.level, .info)
        XCTAssertEqual(mockLogger1.loggedEntries.first?.message, "Info message")
        XCTAssertEqual(mockLogger1.loggedEntries.first?.metadata as? [String: String], ["key": "value"])
    }
    
    func testWarnLog() {
        logsManager.warn("Warning message")
        
        XCTAssertEqual(mockLogger1.loggedEntries.count, 1)
        XCTAssertEqual(mockLogger2.loggedEntries.count, 1)
        XCTAssertEqual(mockLogger1.loggedEntries.first?.level, .warn)
        XCTAssertEqual(mockLogger1.loggedEntries.first?.message, "Warning message")
    }
    
    func testErrorLog() {
        let testError = NSError(domain: "TestDomain",
                                code: 1,
                                userInfo: nil)
        logsManager.error("Error message",
                          error: testError)
        
        XCTAssertEqual(mockLogger1.loggedEntries.count, 1)
        XCTAssertEqual(mockLogger2.loggedEntries.count, 1)
        XCTAssertEqual(mockLogger1.loggedEntries.first?.level, .error)
        XCTAssertEqual(mockLogger1.loggedEntries.first?.message, "Error message")
        XCTAssertEqual(mockLogger1.loggedEntries.first?.error as? NSError, testError)
    }
}

// MARK: - DefaultLogFormatterTests

class DefaultLogFormatterTests: XCTestCase {
    var formatter: DefaultLogFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = DefaultLogFormatter()
    }
    
    func testFormatInfoLog() {
        let entry = LogEntry(level: .info,
                             message: "Info message",
                             file: "TestFile.swift",
                             function: "testFunction()",
                             line: 10)
        let formattedLog = formatter.format(entry)
        
        XCTAssertTrue(formattedLog.contains("ℹ️"))
        XCTAssertTrue(formattedLog.contains("Info message"))
        XCTAssertTrue(formattedLog.contains("TestFile.swift"))
        XCTAssertTrue(formattedLog.contains("testFunction()"))
        XCTAssertTrue(formattedLog.contains("Line: 10"))
    }
    
    func testFormatWarningLog() {
        let entry = LogEntry(level: .warn,
                             message: "Warning message",
                             file: "TestFile.swift",
                             function: "testFunction()",
                             line: 20)
        let formattedLog = formatter.format(entry)
        
        XCTAssertTrue(formattedLog.contains("⚠️"))
        XCTAssertTrue(formattedLog.contains("Warning message"))
    }
    
    func testFormatErrorLog() {
        let entry = LogEntry(level: .error,
                             message: "Error message",
                             file: "TestFile.swift",
                             function: "testFunction()",
                             line: 30)
        let formattedLog = formatter.format(entry)
        
        XCTAssertTrue(formattedLog.contains("🔴"))
        XCTAssertTrue(formattedLog.contains("Error message"))
    }
}

// MARK: - ConsoleLogDestinationTests

class ConsoleLogDestinationTests: XCTestCase {
    var destination: ConsoleLogDestination!
    
    override func setUp() {
        super.setUp()
        destination = ConsoleLogDestination()
    }
    
    func testWrite() {
        // This test is mainly to ensure that the write method doesn't crash
        // We can't easily test console output, so we're just making sure it runs without error
        destination.write("Test log message")
        // If we get here without crashing, the test passes
    }
}

// MARK: - Integration Tests

class IntegrationTests: XCTestCase {
    func testFullLoggingFlow() {
        let formatter = DefaultLogFormatter()
        let destination = ConsoleLogDestination()
        let logger = Logger(formatter: formatter, destinations: [destination])
        let logsManager = LogsManager(loggers: [logger])
        
        // This test doesn't assert anything, it's just to ensure the full flow doesn't crash
        logsManager.info("Info message")
        logsManager.warn("Warning message")
        logsManager.error("Error message", error: NSError(domain: "TestDomain", code: 1, userInfo: nil))
    }
}
