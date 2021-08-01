//
//  ShellRunnerMock.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.06.2021.
//

import XCTest

@testable import CLIUtilsLib

class ShellRunnerMock: IShellRunner {

    func execute(_ line: String) -> ShellResult {
        executeCounter += 1
        return results[executeCounter - 1]
    }

    var results = [ShellResult]()
    var executeCounter = 0
}
