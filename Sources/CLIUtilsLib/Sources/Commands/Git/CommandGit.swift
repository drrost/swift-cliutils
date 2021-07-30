//
//  CommandGit.swift
//
//
//  Created by Rostyslav Druzhchenko on 30.07.2021.
//

import Foundation

public class CommandGit: Command {

    // MARK: - Properties

    var gitUtil: IGitUtil!

    // MARK: - Command

    open override func exec() throws {

        let path = CommandPwd().pwd()
        gitUtil = GitUtil.default(path, shellRunner)
    }
}
