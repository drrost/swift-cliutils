//
//  CommandGit.swift
//
//
//  Created by Rostyslav Druzhchenko on 30.07.2021.
//

import Foundation

public class CommandGit: Command {

    // MARK: - Properties

    var serviceGit: IServideGit!

    // MARK: - Command

    open override func exec() throws {

        let path = CommandPwd().pwd()
        serviceGit = ServideGit.default(path, shellRunner)
    }
}
