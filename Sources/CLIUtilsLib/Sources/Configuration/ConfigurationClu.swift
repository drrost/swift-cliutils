//
//  ConfigurationClu.swift
//
//
//  Created by Rostyslav Druzhchenko on 01.08.2021.
//

import Foundation
import RDDI

public class ApplicationConfigurationClu: IApplicationConfiguration {

    public var name: String = "clu"

    public var factories: [String : IDependencyFactory] = [
        "IShellRunner": ShellRunnerFactory(),
        "IServideGit": ServiceGitFactory()
    ]

    public func add(_ name: String, _ dependency: IDependencyFactory) {

        factories[name] = dependency
    }

    // MARK: - Init

    public init() {}
}

public func DI<T>(_ name: String) -> T {
    DI(name, "clu")
}
