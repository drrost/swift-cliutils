//
//  CommandGitPromptTests.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.06.2021.
//

import XCTest

@testable import CLIUtilsLib

class CommandGitPromptTests: XCTestCase {

    // MARK: - Variables

    var sut: CommandGitPrompt!

    var gitUtil: GitUtilMock!

    // MARK: - Tests routines

    override func setUp() {
        let arguments = CommandArguments("")
        sut = CommandGitPrompt(arguments)

        gitUtil = GitUtilMock("", ShellRunnerMock())
        sut.gitUtil = gitUtil
    }

    // MARK: - Init tests

    func testNothing() {
        // Given
        // When
        // Then
    }
}

class GitUtilMock: IGitUtil {

    var _isGitRepository: Bool = false
    var _localFilesChanged: Int = 0
    var _localCommits: Int = 0
    var _remoteCommits: Int = 0

    required init(_ path: String, _ shellRunner: IShellRunner) {
    }

    func isGitRepository() throws -> Bool {
        _isGitRepository
    }

    func localFilesChanged() throws -> Int {
        _localFilesChanged
    }

    func localCommits() throws -> Int {
        _localCommits
    }

    func remoteCommits() throws -> Int {
        _remoteCommits
    }
}

class ShellRunnerMock: IShellRunner {

    func execute(_ line: String) -> ShellResult {
        ShellResult("", "", 0)
    }
}
