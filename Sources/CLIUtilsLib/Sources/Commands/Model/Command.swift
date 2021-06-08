//
//  Command.swift
//
//
//  Created by Rostyslav Druzhchenko on 17.02.2021.
//

import Foundation
import ExtensionsFoundation

open class Command {

    var name: String { arguments.name }
    public var operands: [String] { arguments.operands }
    public var options: [CommandOption] { arguments.options }
    public var shellRunner: IShellRunner

    private let arguments: CommandArguments

    private init() {
        arguments = CommandArguments("")
        shellRunner = ShellRunner()
    }

    public init(
        _ arguments: CommandArguments,
        _ shellRunner: IShellRunner = ShellRunner()) {

        self.arguments = arguments
        self.shellRunner = shellRunner
    }

    open func exec() {}
}

public class CommandNop: Command {

    init(_ shellRunner: IShellRunner = ShellRunner()) {
        super.init(CommandArguments(""))
    }
}
