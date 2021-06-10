//
//  File.swift
//
//
//  Created by Rostyslav Druzhchenko on 10.06.2021.
//

import Foundation
import ExtensionsFoundation

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

        let files = try listFiles(filter)

        var recList = [File]()
        
        for file in files {
            if file.isDirectory() {
                let inList = try file.listFilesR(filter)
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
