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

    func localCommits() throws -> Int {
        try getCommits("local")
    }

    func remoteCommits() throws -> Int {
        try getCommits("remote")
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

    // MARK: - Private

    private func getCommits(_ input: String) throws -> Int {

        if input != "local" && input != "remote" {
            throw RDError("`input` must be either `local` or `remote`")
        }

        let word = input == "local" ? "ahead" : "behind"

        if !_isGitRepository { return 0 }

        let result = shellRunner.execute(
            "cd \(path) && git for-each-ref --format=\"%(push:track)\" refs/heads")

        if result.exitCode != 0 {
            throw RDError(result.stderr)
        }

        // Expected output:
        //   [ahead 3, behind 2]
        //
        let numbersArray = try result.stdout.regex("\(word) [0-9]+")

        if numbersArray.count < 1 {
            return 0
        }

        let countCandidate = numbersArray[0].split(" ")[1]
        if let count = Int(countCandidate) {
            return count
        }
        throw RDError("Can't convert \(countCandidate) to string")
    }
}
