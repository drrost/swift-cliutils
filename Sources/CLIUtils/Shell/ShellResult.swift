//
//  ShellResult.swift
//
//
//  Created by Rostyslav Druzhchenko on 21.03.2021.
//

import Foundation

public class ShellResult {

    public let stdout: String
    public let stderr: String
    public let exitCode: Int

    public init(_ stdout: String, _ stderr: String, _ exitCode: Int) {
        self.stdout = stdout
        self.stderr = stderr
        self.exitCode = exitCode
    }

    public func output() -> String {
        if stdout.count > 0 {
            return stdout
        }
        return stderr
    }
}
