//
//  ServideGitImpl.swift
//
//
//  Created by Rostyslav Druzhchenko on 30.07.2021.
//

import Foundation
import RDError

extension ServideGitImpl {

    func localBranches() throws -> [Branch] {

        try throwIfNoRepository()

        let result = shellRunner.execute("cd \(path) && git branch")
        try result.throwIfError()

        let branches = parseBranches(result.stdout)
        return branches
    }

    func getInfo(for branches: [Branch]) throws -> [BranchInfo] {

        try branches.map { branch in

            let localChanges =
                branch.isCurrent ? try localFilesChanged() : 0
            let localCommits = try localCommits(branch.name)
            let remoteCommits = try remoteCommits(branch.name)

            let state = BranchState(localChanges, localCommits, remoteCommits)
            return BranchInfo(branch, state)
        }
    }

    // MARK: - Internal

    func parseBranches(_ out: String) -> [Branch] {

        let lines = out.split("\n")

        return lines.map { line in
            let currenBranchSign = "* "
            var name = line.trimN()
            let isCurrent = name.hasPrefix(currenBranchSign)
            if isCurrent {
                name.remove(prefix: currenBranchSign)
            }
            return Branch(name, isCurrent)
        }
    }
}
