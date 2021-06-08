//
//  CommandHelp.swift
//
//
//  Created by Rostyslav Druzhchenko on 17.02.2021.
//

import Foundation

open class CommandHelp: Command {

    open override func exec() {
        for name in COMMAND_LIST.keys {
            System.out.println(name)
        }
    }
}
