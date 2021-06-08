//
//  CommandHelp.swift
//
//
//  Created by Rostyslav Druzhchenko on 17.02.2021.
//

import Foundation

open class CommandHelp: Command {

    let commandList: [String]

    private override init(
        _ arguments: CommandArguments,
        _ shellRunner: IShellRunner = ShellRunner()) {

        commandList = [String]()
        super.init(arguments, shellRunner)
    }

    public init(
        _ arguments: CommandArguments,
        _ commandList: [String],
        _ shellRunner: IShellRunner = ShellRunner()) {

        self.commandList = commandList
        super.init(arguments, shellRunner)
    }

    open override func exec() {
        for name in commandList {
            System.out.println(name)
        }
    }
}
