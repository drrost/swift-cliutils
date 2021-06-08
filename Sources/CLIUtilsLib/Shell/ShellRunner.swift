//
//  ShellRunner.swift
//
//
//  Created by Rostyslav Druzhchenko on 21.03.2021.
//

import Foundation

public protocol IShellRunner {

    func execute(_ line: String) -> ShellResult
}

public class ShellRunner: IShellRunner {

    public init() {}

    public func execute(_ command: String) -> ShellResult {
        shell(command)
    }
}
