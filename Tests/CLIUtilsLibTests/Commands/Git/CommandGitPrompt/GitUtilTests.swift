//
//  GitUtilTests.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.06.2021.
//

import XCTest

@testable import CLIUtilsLib

class GitUtilTests: XCTestCase {

    // MARK: - Variables

    var sut: GitUtilImpl!
    var shellRunnerMock: ShellRunnerMock!

    // MARK: - Tests routines

    override func setUp() {
        shellRunnerMock = ShellRunnerMock()
        sut = GitUtil.default("", shellRunnerMock) as? GitUtilImpl
        sut._isGitRepository = true
    }

    // MARK: - Init tests

    func testBehind2_remoteCommits2() {
        // Given
        shellRunnerMock.stdout = "2\n"

        // When
        let remote = try! sut.remoteCommits("DDD")

        // Then
        XCTAssertEqual(2, remote)
    }

    func testAhead3_localCommits3() {
        // Given
        shellRunnerMock.stdout = "[ahead 3, behind 2]"

        // When
        let local = try! sut.localCommits("AAAD")

        // Then
        XCTAssertEqual(3, local)
    }
}
