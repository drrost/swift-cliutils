//
//  CommandFactory.swift
//
//
//  Created by Rostyslav Druzhchenko on 17.02.2021.
//

import Foundation

public let COMMAND_LIST = [
    "bye" : CommandBye.self,
    "pwd" : CommandPwd.self,
    "help" : CommandHelp.self,

    "rename" : CommandRenameFile.self
]

open class CommandFactory {

    open class func create(from line: String) -> Command {

        CommandFactory().create(from: line)
    }

    func create(from line: String) -> Command {

        let arguments = CommandArguments(line)

        if arguments.name == "" {
            return CommandNop()
        }

        switch arguments.name {
        case "bye", "exit":
            return CommandBye(arguments)
        case "pwd":
            return CommandPwd(arguments)
        case "help":
            return CommandHelp(arguments, COMMAND_LIST.keys.sorted())
        case "rename":
            return CommandRenameFile(arguments)
        default:
            return CommandUnknown(arguments)
        }
    }
}
