//
//  GitStatusPrinter.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.06.2021.
//

import Foundation

class GitStatusPrinter {

    func getStatusString(for state: GitRepositoryState) -> String {

        if !state.isGitRepository { return "" }

        var result = "(\(state.branch))"

        if state.remoteCommits > 0 {
            result += " ▼\(state.remoteCommits)"
        }

        if state.localCommits > 0 {
            if state.remoteCommits > 0 {
                result += "|"
            } else {
                result += " "
            }
            result += "▲\(state.localCommits)"
        }

        if state.localFilesChanged > 0 {
            result += " (\(state.localFilesChanged))"
        }

        result = addColor(state, result)
        
        return result
    }

    private func addColor(
        _ state: GitRepositoryState, _ candidate: String) -> String {

        var color: String = .GREEN
        if state.localFilesChanged > 0 {
            color = .RED
        } else if state.localCommits > 0 {
            color = .YELLOW
        } else if state.remoteCommits > 0 {
            color = .MAGENTA
        }

        return color + candidate + .NC
    }
}

fileprivate extension String {

    static let RED: String = "\\e[0;31m"
    static let GREEN: String = "\\e[0;32m"
    static let YELLOW: String = "\\e[0;33m"
    static let MAGENTA: String = "\\e[0;35m"

    static let NC: String = "\\e[0m"
}
