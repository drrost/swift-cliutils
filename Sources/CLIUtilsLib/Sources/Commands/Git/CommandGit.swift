//
//  CommandGit.swift
//
//
//  Created by Rostyslav Druzhchenko on 30.07.2021.
//

import Foundation

public class CommandGit: Command {

    // MARK: - Properties

    let serviceGit: IServideGit = DI("IServideGit")
}
