//
//  GitUtil.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.06.2021.
//

import Foundation
import RDError

class GitUtil {

    // MARK: - Private

    private init() {}

    // MARK: - Public

    static func `default`(
        _ path: String, _ shellRunner: IShellRunner) -> IGitUtil {

        GitUtilImpl(path, shellRunner)
    }
}

class GitUtilImpl: IGitUtil {

    private let path: String
    private let shellRunner: IShellRunner

    var _isGitRepository: Bool = false

    required init(_ path: String, _ shellRunner: IShellRunner) {
        self.path = path
        self.shellRunner = shellRunner
    }

    func isGitRepository() throws -> Bool {
        let result = shellRunner.execute(
            "cd \(path) && git rev-parse --is-inside-work-tree")
        _isGitRepository = result.stdout.trimN() == "true"
        return _isGitRepository
    }

    func localFilesChanged() throws -> Int {
        if !_isGitRepository { return 0 }
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
        let reuslt = shellRunner.execute(script)
        try reuslt.throwIfError()

        if let count = Int(reuslt.stdout.trimN()) {
            return count
        }
        throw RDError("Can't parse \"\(reuslt.stdout)\" to Int")
    }

    func branchName() throws -> String {

        guard _isGitRepository else { return "" }

        let result = shellRunner.execute(
            "cd \(path) && git branch --show-current")

        if result.exitCode != 0 {
            throw RDError(result.stderr)
        }
        return result.stdout.trimN()
    }
}

extension ShellResult {

    func throwIfError() throws {
        if exitCode != 0 {
            throw RDError(stderr)
        }
    }
}
