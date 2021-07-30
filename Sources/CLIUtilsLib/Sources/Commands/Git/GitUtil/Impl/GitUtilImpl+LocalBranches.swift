//
//  GitUtilImpl.swift
//
//
//  Created by Rostyslav Druzhchenko on 30.07.2021.
//

import Foundation
import RDError

extension GitUtilImpl {

    func localBranches() throws -> [Branch] {

        guard let isrepo = try? isGitRepository(), isrepo else {
            throw RDError("There is no repository in the current folder")
        }

        let result = shellRunner.execute("cd \(path) && git branch")
        try result.throwIfError()

        let branches = parseBranches(result.stdout)
        return branches
    }

    // MARK: - Private

    private func parseBranches(_ out: String) -> [Branch] {

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
