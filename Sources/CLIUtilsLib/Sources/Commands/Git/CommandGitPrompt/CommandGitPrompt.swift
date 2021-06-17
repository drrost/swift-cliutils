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

        do {
            let state = try gitUtil.getRepositoryState()

            let printer = GitStatusPrinter()
            let statusString = printer.getStatusString(for: state)
            System.out.println(statusString)
        } catch {
            System.out.print("")
        }
    }
}

