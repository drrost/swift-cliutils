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

        if state.localFilesChanged > 0 {
            result += " (\(state.localFilesChanged))"
        }

        return result
    }
}
