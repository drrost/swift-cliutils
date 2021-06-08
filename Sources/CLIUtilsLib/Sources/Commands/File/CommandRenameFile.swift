//
//  CommandRenameFile.swift
//
//
//  Created by Rostyslav Druzhchenko on 08.06.2021.
//

import Foundation

/**
 Renames file(s) and/or folder(s) recurcively.

 
 */
public class CommandRenameFile: Command {

    // cu rename -r ./ *Mock* Example

    open override func exec() {

        // Handle options
        // If there is an unkonwn option - print to stderr
        for option in options {
            if option.symbol == "R" {

            } else {
                printIlligalOption(option.symbol)
                printUsage()
            }
        }
    }

    // MARK: - Private

    private func printIlligalOption(_ option: String) {
        System.err.println("\(name): illegal option -- \(option)")
    }

    private func printUsage() {
        System.err.println("usage: \(name) [-R] [path]")
    }
}
