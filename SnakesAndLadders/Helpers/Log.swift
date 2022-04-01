//
//  Log.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 29/03/22.
//

import Foundation
struct Log {
    
    enum LogLevel: Int {
        case trace, debug , info , warn , none
        
        var value: Int {
            switch self {
            case .trace:
                return 0
            case .debug:
                return 1
            case .info:
                return 2
            case .warn:
                return 3
            case .none:
                return 4
            }
        }
    }
    private static let logLevel: LogLevel = .debug
    static public func log(_ message: Any, file: String = (#file as NSString).lastPathComponent, function: String = #function, line: Int = #line, level: LogLevel) {
        if level.value >= logLevel.value {
            print(" \(file): \(function): \(line): \(message) ")
        }
        
    }
}
