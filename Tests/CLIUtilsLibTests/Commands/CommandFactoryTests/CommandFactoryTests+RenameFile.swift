//
//  CommandFactoryTests+RenameFile.swift
//
//
//  Created by Rostyslav Druzhchenko on 08.06.2021.
//

import XCTest

@testable import CLIUtilsLib

extension CommandFactoryTests {

    func testRenameFile() {

        // Given
        let line = "rename"

        // When
        let command = sut.create(from: line)

        // Then
        XCTAssertTrue(command is CommandRenameFile)
    }

    func testRenameFile_OneArgument() {

        // Given
        let line = "rename ./"

        // When
        let command = sut.create(from: line)

        // Then
        XCTAssertTrue(command is CommandRenameFile)
        XCTAssertEqual(["./"], command.operands)
    }

    func testRenameFile_SevralArguments() {

        // Given
        let line = "rename asdf asdf sdf"

        // When
        let command = sut.create(from: line)

        // Then
        XCTAssertTrue(command is CommandRenameFile)
        XCTAssertEqual(["asdf", "asdf", "sdf"], command.operands)
    }

    func testRenameFile_DifferentOptionsCombination() {

        // Given
        let lines = [
            "rename -R",
            "rename -RR",
            "rename -R -R",
            "rename -RR -R",
            "rename -RR -RR",
            "rename -RR -RRRR",
            "rename -RR -R -R -RRR",
        ]

        for line in lines {
            // When
            let command = sut.create(from: line)

            // Then
            let options = [CommandOption("R")]
            XCTAssertTrue(command is CommandRenameFile)
            XCTAssertEqual(options, command.options)
            XCTAssertEqual([], command.operands)
        }
    }

    func testRenameFile_TwoDifferentOptions() {

        // Given
        let lines = [
            "rename -Rd",
            "rename -R -d",
            "rename -R -dddd",
            "rename -R -d -Rd",
        ]

        for line in lines {
            // When
            let command = sut.create(from: line)

            // Then
            let options = [CommandOption("R"), CommandOption("d")]

            XCTAssertTrue(command is CommandRenameFile)
            XCTAssertEqual(options, command.options)
            XCTAssertEqual([], command.operands)
        }
    }

    func testRenameFile_DifferentOptionsDifferentOperands() {

        // Given
        let line = "rename -Rd asd ddd d"

        // When
        let command = sut.create(from: line)

        // Then
        let options = [CommandOption("R"), CommandOption("d")]

        XCTAssertTrue(command is CommandRenameFile)
        XCTAssertEqual(options, command.options)
        XCTAssertEqual(["asd", "ddd", "d"], command.operands)
    }
}

