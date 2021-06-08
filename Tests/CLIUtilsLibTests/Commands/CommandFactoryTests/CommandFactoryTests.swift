//
//  CommandFactoryTests.swift
//
//
//  Created by Rostyslav Druzhchenko on 08.06.2021.
//

import XCTest

@testable import CLIUtilsLib

class CommandFactoryTests: XCTestCase {

    // MARK: - Variables

    var sut: CommandFactory!

    // MARK: - Tests routines

    override func setUp() {
        sut = CommandFactory()
    }

    // MARK: - Tests

    func testEmptyLine_CreatesNopCommand() {

        // Given
        let line = ""

        // When
        let command = sut.create(from: line)

        // Then
        XCTAssertTrue(command is CommandNop)
    }

    func testByeLine_CreatesByeCommand() {

        // Given
        let line = "bye"

        // When
        let command = sut.create(from: line)

        // Then
        XCTAssertTrue(command is CommandBye)
    }

    func testRandomLine_CreatesUnknownCommand() {

        // Given
        let line = "asdfasdf"

        // When
        let command = sut.create(from: line)

        // Then
        XCTAssertTrue(command is CommandUnknown)
    }

    func testPwdLine_CreatesPwdCommand() {

        // Given
        let line = "pwd"

        // When
        let command = sut.create(from: line)

        // Then
        XCTAssertTrue(command is CommandPwd)
    }
}
