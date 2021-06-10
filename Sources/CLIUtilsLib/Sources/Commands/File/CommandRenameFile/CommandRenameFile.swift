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

        for option in options {
            if option.symbol == "R" {

            } else {
                printIlligalOption(option.symbol)
                printUsage()
                return
            }
        }

        // Get files/folders
    }

    override func printUsage() {
        System.err.println("usage: \(name) [-R] [path]")
    }

    // MARK: - Private

    private func getAllEntities() -> [File] {
        []
    }
}
