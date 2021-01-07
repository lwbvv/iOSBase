//
//  ConsoleLog.swift
//  ProxyModule
//
//  Created by Appg on 2021/01/04.
//

import WebKit

public enum Level {
    case fatal
    case error
    case warn
    case info
    case debug
    case trace
    
}

public let overrideConsole = """
    function log(emoji, type, args) {
      window.webkit.messageHandlers.logging.postMessage(
        `${emoji} JS ${type}: ${Object.values(args)}`
      )
    }

    let originalLog = console.log
    let originalWarn = console.warn
    let originalError = console.error
    let originalDebug = console.debug

    console.log = function() { log("📗", "log", arguments); originalLog.apply(null, arguments) }
    console.warn = function() { log("📙", "warning", arguments); originalWarn.apply(null, arguments) }
    console.error = function() { log("📕", "error", arguments); originalError.apply(null, arguments) }
    console.debug = function() { log("📘", "debug", arguments); originalDebug.apply(null, arguments) }

    window.addEventListener("error", function(e) {
       log("💥", "Uncaught", [`${e.message} at ${e.filename}:${e.lineno}:${e.colno}`])
    })
"""

public func Log<T>(_ object: T?, level: Level = .info, filename: String = #file, line: Int = #line, funcName: String = #function){
    #if DEBUG
    let th = Thread.current.isMainThread ? "main": Thread.current.name ?? "-"
    if let obj = object {
        switch level {
        case .fatal:
            print("***** 🔴Level: fatal \(Date()) \(th) \(filename.components(separatedBy: "/").last ?? "") (LINE\(line)) :: \(funcName) :: \(obj)")
        case .error:
            print("***** 🟠Level: error \(Date()) \(th) \(filename.components(separatedBy: "/").last ?? "") (LINE\(line)) :: \(funcName) :: \(obj)")
        case .warn:
            print("***** 🟡Level: warn \(Date()) \(th) \(filename.components(separatedBy: "/").last ?? "") (LINE\(line)) :: \(funcName) :: \(obj)")
        case .info:
            print("***** 🟢Level: info \(Date()) \(th) \(filename.components(separatedBy: "/").last ?? "") (LINE\(line)) :: \(funcName) :: \(obj)")
        case .debug:
            print("***** 🟣Level: debug \(Date()) \(th) \(filename.components(separatedBy: "/").last ?? "") (LINE\(line)) :: \(funcName) :: \(obj)")
        case .trace:
            print("***** 🔵Level: trace \(Date()) \(th) \(filename.components(separatedBy: "/").last ?? "") (LINE\(line)) :: \(funcName) :: \(obj)")
        }
        
    } else{
        print("***** \(Date()) \(th) \(filename.components(separatedBy: "/").last ?? "") (LINE\(line)) :: \(funcName) :: nil")
        
    }
    #endif

}




