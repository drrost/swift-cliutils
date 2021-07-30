//
//  FileTests.swift
//
//
//  Created by Rostyslav Druzhchenko on 10.06.2021.
//

import XCTest

import RDTest

@testable import CLIUtilsLib

class FileTests: CleanableTestCase {

    // MARK: - Variables

    open override var directoriesToDelete: [String] {
        ["/tmp/a", "/tmp/z"]
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

    func testListFilter() {
        // Given
        try! FileManager.createDirectory("/tmp/a/b/")
        try! FileManager.createDirectory("/tmp/a/adb/")
        try! FileManager.createDirectory("/tmp/a/c/")
        try! FileManager.createDirectory("/tmp/a/a/")
        try! FileManager.createDirectory("/tmp/a/aa/")

        // When
        let list = try! File("/tmp/a").list({ $0.matches("a")})

        // Then
        XCTAssertEqual(3, list.count)
        XCTAssertEqual("a", list[0])
        XCTAssertEqual("adb", list[1])
        XCTAssertEqual("aa", list[2])
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

    func testListFilesFilter() {
        // Given
        try! FileManager.createDirectory("/tmp/a/b/")
        try! FileManager.createDirectory("/tmp/a/adb/")
        try! FileManager.createDirectory("/tmp/a/c/")
        try! FileManager.createDirectory("/tmp/a/a/")
        try! FileManager.createDirectory("/tmp/a/aa/")

        // When
        let list = try! File("/tmp/a").listFiles({ $0.matches("a")}).map {
            $0.path.lastPathComponent
        }

        // Then
        XCTAssertEqual(3, list.count)
        XCTAssertEqual("a", list[0])
        XCTAssertEqual("adb", list[1])
        XCTAssertEqual("aa", list[2])
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

    func testListFilesRFilter() {
        // Given
        try! FileManager.createDirectory("/tmp/z/b/")
        try! FileManager.createDirectory("/tmp/z/adb/")
        try! FileManager.createDirectory("/tmp/z/c/")
        try! FileManager.createDirectory("/tmp/z/a/")
        try! FileManager.createDirectory("/tmp/z/aa/")
        try! FileManager.createDirectory("/tmp/z/aa/ac")
        try! FileManager.createDirectory("/tmp/z/aa/dd")
        try! FileManager.createDirectory("/tmp/z/aa/a")

        // When
        let list = try! File("/tmp/z").listFilesR {
            $0.lastPathComponent.matches("a")
        }

        // Then
        XCTAssertEqual(5, list.count)
    }
}
