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

    "rename" : CommandRenameFile.self,

    "git_prompt": CommandGitPrompt.self,
    "glb": CommandGitLocalBranches.self,
    "gsb": CommandGitSwitchBranch.self
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

        case "git_prompt", "gp":
            return CommandGitPrompt(arguments)
        case "glb":
            return CommandGitLocalBranches(arguments)
        case "gsb":
            return CommandGitSwitchBranch(arguments)

        default:
            return CommandUnknown(arguments)
        }
    }
}
