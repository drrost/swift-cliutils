//
//  ServiceGitFactory.swift
//
//
//  Created by Rostyslav Druzhchenko on 01.08.2021.
//

import Foundation
import RDDI

class ServiceGitFactory: IDependencyFactory {

    func getDependency() throws -> IDependency {

        let path = CommandPwd().pwd()
        let shellRunner: IShellRunner = DI("IShellRunner")

        return ServideGit.default(path, shellRunner)
    }
}
