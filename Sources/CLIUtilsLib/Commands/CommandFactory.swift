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
    "help" : CommandHelp.self
]

open class CommandFactory {

    open class func create(from line: String) -> Command {

        var array = line.split(" ")
        if array.count == 0 {
            return CommandNop("", [])
        }

        let name = array[0]
        array.removeFirst()

        switch name {
        case "bye", "exit":
            return CommandBye(name, array)
        case "pwd":
            return CommandPwd(name, array)
        case "help":
            return CommandHelp(name, array)
        default:
            return CommandUnknown(name, array)
        }
    }
}
