//
//  GitUtil.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.06.2021.
//

import Foundation

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
        let result = shellRunner.execute("git rev-parse --is-inside-work-tree")
        _isGitRepository = result.exitCode == 0
        return _isGitRepository
    }

    func localFilesChanged() throws -> Int {
        if !_isGitRepository { return 0 }
        return 0
    }

    func localCommits() throws -> Int {
        if !_isGitRepository { return 0 }
        return 0
    }

    func remoteCommits() throws -> Int {
        if !_isGitRepository { return 0 }
        return 0
    }
}
