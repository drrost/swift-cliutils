//
//  FileTests.swift
//
//
//  Created by Rostyslav Druzhchenko on 10.06.2021.
//

import XCTest

import ExtensionXCTest

@testable import CLIUtilsLib

class FileTests: CleanableTestCase {

    // MARK: - Variables

    open override var directoriesToDelete: [String] {
        ["/tmp/a"]
    }

    var sut: FileTests!

    // MARK: - Init tests

    func testList() {
        // Given
        let path = "/tmp/a/b/c"
        try! FileManager.createDirectory(path)

        // When
        let list = try! File("/tmp/a").list()

        // Then
        XCTAssertEqual(1, list.count)
    }

    func testListR() {
        // Given
        let path = "/tmp/a/b/c/d"
        try! FileManager.createDirectory(path)

        // When
        let list = try! File("/tmp/a").listR()

        // Then
        XCTAssertEqual(3, list.count)
    }

    func testListFiles() {
        // Given
        let path = "/tmp/a/b/c"
        try! FileManager.createDirectory(path)

        // When
        let list = try! File("/tmp/a").listFiles()

        // Then
        XCTAssertEqual(1, list.count)
    }

    func testListFilesR() {
        // Given
        let path = "/tmp/a/b/c/d"
        try! FileManager.createDirectory(path)

        // When
        let list = try! File("/tmp/a").listFilesR()

        // Then
        XCTAssertEqual(3, list.count)
    }
}
