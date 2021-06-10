//
//  CommandRenameFile.swift
//
//
//  Created by Rostyslav Druzhchenko on 08.06.2021.
//

import Foundation

import RDError
import ExtensionsFoundation

/**
 Renames file(s) and/or folder(s) recurcively.

 
 */
public class CommandRenameFile: Command {

    // cu rename -r ./ *Mock* Example

    open override func exec() {

        guard let _ = try? handleInput() else { return }

        System.out.println("!!!")
//        let path = "/Users/rost/Downloads/temp/paymenthandler-mock"
        let path = CommandPwd().pwd()

        System.out.println("pwd: \(path)")

        let file = File(path)

        var list = try! file.listFilesR()

        list = list.filter { $0.path.matches("Mock") }

        list.forEach { System.out.println("\($0.path)") }

        // Get files/folders
    }

    override func printUsage() {
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
