//
//  CommandGitLocalBranches.swift
//
//
//  Created by Rostyslav Druzhchenko on 30.07.2021.
//

import Foundation

public class CommandGitLocalBranches: Command {

    var gitUtil: IGitUtil!

    open override func exec() throws {

        let path = CommandPwd().pwd()
        gitUtil = GitUtil.default(path, shellRunner)

        let branches = try gitUtil.localBranches()

        let printer = GitBranchesPrinter()
        let branchesString = printer.getBranchesString(branches)
        System.out.println(branchesString)
    }
}