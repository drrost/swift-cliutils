//
//  CommandGitRemoteBranches.swift
//
//
//  Created by Rostyslav Druzhchenko on 02.08.2021.
//

import Foundation

class CommandGitRemoteBranches: CommandGit {

    open override func exec() throws {

        try super.exec()

        let branches = try serviceGit.remoteBranches()

        let printer = GitBranchesRemoteFormatter()
        let branchesString = printer.getBranchesString(branches)

        System.out.println(branchesString)
    }
}
