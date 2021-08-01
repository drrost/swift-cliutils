//
//  CommandGitPrompt.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.06.2021.
//

import Foundation

class CommandGitPrompt: CommandGit {

    // MARK: - Command

    open override func exec() throws {

        try super.exec()

        let state = try serviceGit.getRepositoryState()

        let printer = GitStatusFormatter()
        let statusString = printer.getStatusString(for: state)
        System.out.println(statusString)
    }
}

