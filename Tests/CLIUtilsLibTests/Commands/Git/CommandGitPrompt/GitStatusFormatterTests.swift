//
//  GitStatusFormatterTests.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.06.2021.
//

import XCTest

@testable import CLIUtilsLib

class GitStatusFormatterTests: XCTestCase {

    // MARK: - Variables

    var sut: GitStatusFormatter!

    // MARK: - Tests routines

    override func setUp() {
        sut = GitStatusFormatter()
    }

    // MARK: - Init tests

    func test1000M() {
        // Given
        let state = GitRepositoryState(true, 0, 0, 0, "master")

        // When
        let result = sut.getStatusString(for: state)

        // Then
        XCTAssertEqual(" \\e[0;32m(master)\\e[0m", result)
    }

    func test1500M() {
        // Given
        let state = GitRepositoryState(true, 5, 0, 0, "master")

        // When
        let result = sut.getStatusString(for: state)

        // Then
        XCTAssertEqual(" \\e[0;31m(master) (5)\\e[0m", result)
    }

    func test1530M() {
        // Given
        let state = GitRepositoryState(true, 5, 3, 0, "master")

        // When
        let result = sut.getStatusString(for: state)

        // Then
        XCTAssertEqual(" \\e[0;31m(master) ▲3 (5)\\e[0m", result)
    }

    func test1504M() {
        // Given
        let state = GitRepositoryState(true, 5, 0, 4, "master")

        // When
        let result = sut.getStatusString(for: state)

        // Then
        XCTAssertEqual(" \\e[0;31m(master) ▼4 (5)\\e[0m", result)
    }

    func test1534M() {
        // Given
        let state = GitRepositoryState(true, 5, 3, 4, "master")

        // When
        let result = sut.getStatusString(for: state)

        // Then
        XCTAssertEqual(" \\e[0;31m(master) ▼4|▲3 (5)\\e[0m", result)
    }
}

extension GitRepositoryState {

    public convenience init(
        _ isValidGitRepository: Bool,
        _ localFilesChanged: Int,
        _ localCommits: Int,
        _ remoteCommits: Int,
        _ name: String) {

        let branch = Branch(name)
        let state = BranchState(localFilesChanged, localCommits, remoteCommits)
        let info = BranchInfo(branch, state)

        self.init(isValidGitRepository, info)
    }
}
