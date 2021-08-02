//
//  ServideGitImpl+RemoteBranches.swift
//
//
//  Created by Rostyslav Druzhchenko on 02.08.2021.
//

import Foundation
import RDError

extension ServideGitImpl {

    func remoteBranches() throws -> [Branch] {

        try throwIfNoRepository()

        let result = shellRunner.execute("cd \(path) && git branch -r")
        try result.throwIfError()

        let branches = parseBranches(result.stdout)
        return branches
    }
}
