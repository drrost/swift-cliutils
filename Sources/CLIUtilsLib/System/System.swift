//
//  System.swift
//
//
//  Created by Rostyslav Druzhchenko on 22.03.2021.
//

import Foundation

public class System {

    public static let out: PrintStream = PrintStream(FileHandle.standardOutput)
    public static let err: PrintStream = PrintStream(FileHandle.standardError)
}

public class PrintStream {

    private let fileHandle: FileHandle

    init(_ fileHandle: FileHandle) {
        self.fileHandle = fileHandle
    }

    public func print(_ message: String) {
        fileHandle.write(message.data(using: .utf8)!)
    }

    public func println(_ message: String) {
        print(message)
        print("\n")
    }
}
