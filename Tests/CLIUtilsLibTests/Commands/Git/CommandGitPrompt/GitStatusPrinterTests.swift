//
//  GitStatusPrinterTests.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.06.2021.
//

import XCTest

@testable import CLIUtilsLib

class GitStatusPrinterTests: XCTestCase {

    // MARK: - Variables

    var sut: GitStatusPrinter!

    // MARK: - Tests routines

    override func setUp() {
        sut = GitStatusPrinter()
    }

    // MARK: - Init tests

    func test1000M() {
        // Given
        let state = GitRepositoryState(true, 0, 0, 0, "master")

        // When
        let result = sut.getStatusString(for: state)

        // Then
        XCTAssertEqual("(master)", result)
    }

    func test1500M() {
        // Given
        let state = GitRepositoryState(true, 5, 0, 0, "master")

        // When
        let result = sut.getStatusString(for: state)

        // Then
        XCTAssertEqual("(master) (5)", result)
    }
}

