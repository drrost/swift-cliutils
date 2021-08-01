//
//  ServideGitTests.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.06.2021.
//

import XCTest

@testable import CLIUtilsLib

class ServideGitTests: XCTestCase {

    // MARK: - Variables

    var sut: ServideGitImpl!
    var shellRunnerMock: ShellRunnerMock!

    // MARK: - Tests routines

    override func setUp() {
        shellRunnerMock = ShellRunnerMock()
        sut = ServideGit.default("", shellRunnerMock) as? ServideGitImpl
        sut._isValidGitRepository = true
    }

    // MARK: - Init tests

    func testBehind2_remoteCommits2() {
        // Given
        shellRunnerMock.results.append(ShellResult("2\n", "", 0))

        // When
        let remote = try! sut.remoteCommits("DDD")

        // Then
        XCTAssertEqual(2, remote)
    }

    func testAhead3_localCommits3() {
        // Given
        shellRunnerMock.results.append(ShellResult("3\n", "", 0))

        // When
        let local = try! sut.localCommits("AAAD")

        // Then
        XCTAssertEqual(3, local)
    }

    func testParseLocalBranches() {
        // Given
        shellRunnerMock.results.append(ShellResult("true\n", "", 0))
        shellRunnerMock.results.append(ShellResult("""
            * master
              user/bug/fix_leaks_in_database
              story/main/HJ-3909
              story/main/unified-payment-progress-branch
              story/user/HJ-9900-Copy
            """, "", 0))

        // When
        let branches = try! sut.localBranches()

        // Then
        XCTAssertEqual(5, branches.count)
        XCTAssertTrue(branches[0].isCurrent)
        XCTAssertEqual("master", branches[0].name)
        XCTAssertEqual("story/user/HJ-9900-Copy", branches[4].name)
    }
}
