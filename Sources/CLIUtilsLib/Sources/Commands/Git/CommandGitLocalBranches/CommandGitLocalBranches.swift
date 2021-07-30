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
        let infos = try getInfos(branches)

        let printer = GitBranchesFormatter()
        let branchesString = printer.getBranchesString(infos)

        System.out.println(branchesString)
    }

    // MARK: - Private

    private func getInfos(_ branches: [Branch]) throws -> [BranchInfo] {

        try branches.map { branch in

            let localChanges =
                branch.isCurrent ? try gitUtil.localFilesChanged() : 0
            let localCommits = try gitUtil.localCommits(branch.name)
            let remoteCommits = try gitUtil.remoteCommits(branch.name)

            let state = BranchState(localChanges, localCommits, remoteCommits)
            return BranchInfo(branch, state)
        }
    }
}
