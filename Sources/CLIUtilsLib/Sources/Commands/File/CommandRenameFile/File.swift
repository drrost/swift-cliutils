//
//  File.swift
//
//
//  Created by Rostyslav Druzhchenko on 10.06.2021.
//

import Foundation
import ExtensionsFoundation

class File {

    let path: String

    init(_ pathname: String) {
        self.path = pathname
    }

    func isDirectory() -> Bool {
        FileManager.isDirectory(path)
    }

    func list() throws -> [String] {
        try FileManager.list(path)
    }

    func listR() throws -> [String] {
        let list = try listFilesR()
        return list.map { $0.path }
    }

    func listFiles() throws -> [File] {

        let list = try list()

        let files = list.map { File(path.appendingPathComponent($0)) }

        return files
    }

    func listFilesR() throws -> [File] {

        let files = try listFiles()

        var recList = [File]()
        for file in files {
            if file.isDirectory() {
                let inList = try file.listFilesR()
                recList += inList
            }
        }

        return files + recList
    }
}

extension FileManager {

    static func list(_ path: String) throws -> [String] {
        try FileManager.default.contentsOfDirectory(atPath: path)
    }
}
