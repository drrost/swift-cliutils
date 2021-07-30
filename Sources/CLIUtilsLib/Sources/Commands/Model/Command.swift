//
//  Command.swift
//
//
//  Created by Rostyslav Druzhchenko on 17.02.2021.
//

import Foundation
import RDFoundation

open class Command {

    // MARK: - Variables

    var name: String { arguments.name }
    public var operands: [String] { arguments.operands }
    public var options: [CommandOption] { arguments.options }
    public var shellRunner: IShellRunner

    private let arguments: CommandArguments

    // MARK: - Init

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

    // MARK: - Public

    open func exec() throws {}

    // MARK: - Internal

    func printIlligalOption(_ option: String) {
        System.err.println("\(name): illegal option -- \(option)")
    }

    func printUsage() {
        System.err.println("usage: \(name) [-...] [...]")
    }
}

public class CommandNop: Command {

    init(_ shellRunner: IShellRunner = ShellRunner()) {
        super.init(CommandArguments(""))
    }
}
