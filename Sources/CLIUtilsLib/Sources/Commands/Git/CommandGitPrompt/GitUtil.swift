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

private class GitUtilImpl: IGitUtil {

    private let path: String
    private let shellRunner: IShellRunner

    private var _isGitRepository: Bool = false

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

    func localCommits() throws -> Int {
        if !_isGitRepository { return 0 }
        return 0
    }

    func remoteCommits() throws -> Int {
        if !_isGitRepository { return 0 }
        return 0
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
