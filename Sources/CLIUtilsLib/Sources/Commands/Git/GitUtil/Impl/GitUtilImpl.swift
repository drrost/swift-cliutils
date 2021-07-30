//
//  GitUtilImpl.swift
//
//
//  Created by Rostyslav Druzhchenko on 30.07.2021.
//

import Foundation
import RDError

class GitUtilImpl: IGitUtil {

    let path: String
    let shellRunner: IShellRunner

    var _isValidGitRepository: Bool = false

    required init(_ path: String, _ shellRunner: IShellRunner) {
        self.path = path
        self.shellRunner = shellRunner
    }

    func isValidGitRepository() throws -> Bool {
        let result = shellRunner.execute(
            "cd \(path) && git rev-parse --is-inside-work-tree")
        _isValidGitRepository = result.stdout.trimN() == "true"
        return _isValidGitRepository
    }

    func localFilesChanged() throws -> Int {
        if !_isValidGitRepository { return 0 }
        let result = shellRunner.execute("cd \(path) && git status --porcelain")

        if result.exitCode != 0 {
            throw RDError(result.stderr)
        }

        let count = result.stdout.split("\n").count

        return count
    }

    func localCommits(_ branch: String) throws -> Int {
        let script =
            "cd \(path) && git rev-list origin/\(branch)..\(branch) --count"
        let reuslt = shellRunner.execute(script)
        try reuslt.throwIfError()

        if let count = Int(reuslt.stdout.trimN()) {
            return count
        }
        throw RDError("Can't parse \"\(reuslt.stdout)\" to Int")
    }

    func remoteCommits(_ branch: String) throws -> Int {
        let script =
            "cd \(path) && git rev-list \(branch)..origin/\(branch) --count"
        let result = shellRunner.execute(script)
        try result.throwIfError()

        if let count = Int(result.stdout.trimN()) {
            return count
        }
        throw RDError("Can't parse \"\(result.stdout)\" to Int")
    }

    func branchName() throws -> String {

        guard _isValidGitRepository else { return "" }

        let result = shellRunner.execute(
            "cd \(path) && git branch --show-current")

        if result.exitCode != 0 {
            throw RDError(result.stderr)
        }
        return result.stdout.trimN()
    }

    func branchHasRemote(_ name: String) throws -> Bool {

        let result = shellRunner.execute(
            "cd \(path) && git show-branch remotes/origin/\(name)")

        return result.exitCode == 0
    }

    func switchTo(_ branch: Branch) throws {

        let result = shellRunner.execute("cd \(path) && git checkout \(branch.name)")
        try result.throwIfError()
    }
}

extension ShellResult {

    func throwIfError() throws {
        if exitCode != 0 {
            throw RDError(stderr)
        }
    }
}
