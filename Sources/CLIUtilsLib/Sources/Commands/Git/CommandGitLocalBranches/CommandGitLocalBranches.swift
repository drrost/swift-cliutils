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
        let infos = try getInfos(branches)

        let printer = GitBranchesFormatter()
        let branchesString = printer.getBranchesString(infos)
        System.out.println(branchesString)
    }

    // MARK: - Private

    private func getInfos(_ branches: [Branch]) throws -> [BranchInfo] {

        var infos: [BranchInfo] = []

        for branch in branches {
            var localChanges = 0
            if branch.isCurrent {
                localChanges = try gitUtil.localFilesChanged()
            }
            let localCommits = try gitUtil.localCommits(branch.name)
            let remoteCommits = try gitUtil.remoteCommits(branch.name)

            let state = BranchState(localChanges, localCommits, remoteCommits)
            let info = BranchInfo(branch, state)
            infos.append(info)
        }

        return infos
    }
}
