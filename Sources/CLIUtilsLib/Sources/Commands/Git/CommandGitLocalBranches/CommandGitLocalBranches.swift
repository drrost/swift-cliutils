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

        let branches = try gitUtil.localBranches()
        let infos = try gitUtil.getInfo(for: branches)

        let printer = GitBranchesFormatter()
        let branchesString = printer.getBranchesString(infos)

        System.out.println(branchesString)
    }
}
