//
//  CommandGitPrompt.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.06.2021.
//

import Foundation

class CommandGitPrompt: Command {

    // MARK: - Properties

    var gitUtil: IGitUtil!

    // MARK: - Command

    open override func exec() throws {

        let path = CommandPwd().pwd()
        gitUtil = GitUtil.default(path, shellRunner)

        let state = try gitUtil.getRepositoryState()

        if state.isGitRepository {
            System.out.println("Is in a git repository")
            System.out.println("On branch: \(state.branch)")
            System.out.println("Files changed: \(state.localFilesChanged)")
            System.out.println("Local commits: \(state.localCommits)")
        } else {
            System.err.println("Is NOT in a git repository")
        }
    }
}
