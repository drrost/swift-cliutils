//
//  CommandRenameFile.swift
//
//
//  Created by Rostyslav Druzhchenko on 08.06.2021.
//

import Foundation

import RDError
import RDFoundation

/**
 Renames file(s) and/or folder(s) recurcively.

 
 */
public class CommandRenameFile: Command {

    // cu rename -r ./ *Mock* Example

    open override func exec() {

        guard let _ = try? handleInput() else { return }

        let path = CommandPwd().pwd()

        let file = File(path)
        let list = try! file.listFilesR {
            $0.lastPathComponent.matches("Mock")
        }.sorted {
            $1.isDirectory()
        }.forEach {
            System.out.println("\($0.path)")
        }
    }

    public override func printUsage() {
        System.err.println("usage: \(name) [-R] [path]")
    }

    // MARK: - Private

    private func handleInput() throws {

        for option in options {
            if option.symbol == "R" {

            } else {
                printIlligalOption(option.symbol)
                printUsage()
                throw RDError("Invalid input")
            }
        }

        if operands.count == 0 {
            System.err.println("Path is not specified")
            printUsage()
            throw RDError("Invalid input")
        }
    }
}
