//
//  Command.swift
//
//
//  Created by Rostyslav Druzhchenko on 17.02.2021.
//

import Foundation
import ExtensionsFoundation

open class Command {

    let command: String
    public let arguments: [String]
    public let shellRunner: IShellRunner

    public init(
        _ line: String,
        _ arguments: [String],
        shellRunner: IShellRunner = ShellRunner()) {

        command = line
        self.arguments = arguments
        self.shellRunner = shellRunner
    }

    open func exec() {}
}

public class CommandNop: Command {
}
