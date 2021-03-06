//
//  GitStatusFormatter.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.06.2021.
//

import Foundation

class GitStatusFormatter {

    func getStatusString(for repositoryState: GitRepositoryState) -> String {

        if !repositoryState.isValidGitRepository { return "" }

        var result = "(\(repositoryState.branchInfo.branch.name))"
        let state = repositoryState.branchInfo.state
        result += state.toString()

        result = addColor(state, result)

        return " " + result
    }

    private func addColor(_ state: BranchState, _ candidate: String) -> String {

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

public extension BranchState {

    func toString() -> String {

        var result = ""
        if remoteCommits > 0 {
            result += " ▼\(remoteCommits)"
        }

        if localCommits > 0 {
            if remoteCommits > 0 {
                result += "|"
            } else {
                result += " "
            }
            result += "▲\(localCommits)"
        }

        if localFilesChanged > 0 {
            result += " (\(localFilesChanged))"
        }

        return result
    }
}
