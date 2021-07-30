//
//  CommandGitSwitchBranch.swift
//
//
//  Created by Rostyslav Druzhchenko on 30.07.2021.
//

import Foundation
import RDError

public class CommandGitSwitchBranch: Command {

    var gitUtil: IGitUtil!

    open override func exec() throws {

       try validateInput()

        let path = CommandPwd().pwd()
        gitUtil = GitUtil.default(path, shellRunner)

        let branches = try gitUtil.localBranches()
        let number = Int(arguments.operands[0])! - 1

        if number >= branches.count || number < 0 {
            throw RDError(
                "Passed argument must be in the range [1..\(branches.count)]")
        }

        try gitUtil.switchTo(branches[number])
    }

    public override func printUsage() {
        System.err.println("usage: \(name) [number]")
    }

    // MARK: - Private

    private func validateInput() throws {

        if arguments.operands.count == 0 {
            throw RDError("There must be an integer in arguments list")
        }

        guard Int(arguments.operands[0]) != nil else {
            throw RDError("The passed arguement must be a positive integer")
        }
    }
}
