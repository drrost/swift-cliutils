//
//  CommandHelp.swift
//
//
//  Created by Rostyslav Druzhchenko on 17.02.2021.
//

import Foundation

open class CommandHelp: Command {

    let commandList: [String: Command.Type]

    private override init(
        _ arguments: CommandArguments,
        _ shellRunner: IShellRunner = ShellRunner()) {

        commandList = [String: Command.Type]()
        super.init(arguments, shellRunner)
    }

    init(
        _ arguments: CommandArguments,
        _ commandList: [String: Command.Type],
        _ shellRunner: IShellRunner = ShellRunner()) {

        self.commandList = commandList
        super.init(arguments, shellRunner)
    }

    open override func exec() {
        for name in commandList.keys.sorted() {
            System.out.println(name)
        }
    }
}
