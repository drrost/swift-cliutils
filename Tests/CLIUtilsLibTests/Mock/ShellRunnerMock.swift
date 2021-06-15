//
//  ShellRunnerMock.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.06.2021.
//

import XCTest

@testable import CLIUtilsLib

class ShellRunnerMock: IShellRunner {

    var stdout: String = ""
    var stderr: String = ""
    var exitCode: Int = 0

    func execute(_ line: String) -> ShellResult {
        ShellResult(stdout, stderr, exitCode)
    }
}
