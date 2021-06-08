//
//  main.swift
//  CLIUtils
//
//  Created by Rostyslav Druzhchenko on 08.06.2021.
//

import Foundation
import CLIUtilsLib

class Inner {

    private static let file = FileHandle.standardInput

    static func getLine() -> String {
        let data = file.availableData
        let line = String(bytes: data, encoding: .utf8)!
        return String(line.dropLast())
    }
}

// Handle pipe mode
//
if isatty(fileno(stdout)) == 0 {
    let line = CommandLine.arguments
    guard line.count > 1 else { exit(0) }

    handleInput(CommandLine.arguments)
    exit(0)
}

func handleInput(_ arguments: [String]) {
    var inArguments = arguments
    if inArguments.count > 0 {
        inArguments.removeFirst()
    }

    let line = inArguments.joined(separator: " ")
    let command = CommandFactory.create(from: line)
    command.exec()
}

if CommandLine.arguments.count > 1 {
    handleInput(CommandLine.arguments)
    exit(0)
}

// Handle regular mode
//
func printPrompt() {
    System.out.print("> ")
}

while true {

    printPrompt()
    let line = Inner.getLine();
    let command = CommandFactory.create(from: line)
    command.exec()
}
