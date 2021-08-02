//
//  CommandGitLocalBranches.swift
//
//
//  Created by Rostyslav Druzhchenko on 30.07.2021.
//

import Foundation

public class CommandGitLocalBranches: CommandGit {

    open override func exec() throws {

        try super.exec()

        let branches = try serviceGit.localBranches()
        let infos = try serviceGit.getInfo(for: branches)

        let printer = GitBranchesLocalFormatter()
        let branchesString = printer.getBranchesString(infos)

        System.out.println(branchesString)
    }
}
