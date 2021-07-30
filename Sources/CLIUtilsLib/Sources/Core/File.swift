//
//  File.swift
//
//
//  Created by Rostyslav Druzhchenko on 10.06.2021.
//

import Foundation
import RDFoundation

public typealias Filter = ((String) -> Bool)

public class File {

    let path: String

    public init(_ pathname: String) {
        self.path = pathname
    }

    public func isDirectory() -> Bool {
        FileManager.isDirectory(path)
    }

    public func list(_ filter: Filter = {_ in true}) throws -> [String] {
        try FileManager.list(path).filter { filter($0) }
    }

    public func listR(_ filter: Filter = {_ in true}) throws -> [String] {
        try listFilesR(filter).map { $0.path }
    }

    public func listFiles(_ filter: Filter = {_ in true}) throws -> [File] {
        try list().filter { filter($0) }.map { File(path.appendingPathComponent($0)) }
    }

    public func listFilesR(_ filter: Filter = {_ in true}) throws -> [File] {

        let files = try listFiles()

        let content = try files.filter {
            $0.isDirectory()
        }.reduce([File]()) {
            $0 + (try $1.listFilesR(filter))
        }

        return files.filter { filter($0.path) } + content
    }
}

extension FileManager {

    static func list(_ path: String) throws -> [String] {
        try FileManager.default.contentsOfDirectory(atPath: path)
    }
}
