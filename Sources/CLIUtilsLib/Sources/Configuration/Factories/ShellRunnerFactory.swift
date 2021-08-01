//
//  ShellRunnerFactory.swift
//
//
//  Created by Rostyslav Druzhchenko on 01.08.2021.
//

import Foundation
import RDDI

class ShellRunnerFactory: IDependencyFactory {

    func getDependency() throws -> IDependency {
        ShellRunner()
    }
}

extension ShellRunner: IDependency {

    public var name: String { "IShellRunner" }
}
