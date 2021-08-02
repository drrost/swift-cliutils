//
//  GitBranchesRemoteFormatter.swift
//
//
//  Created by Rostyslav Druzhchenko on 02.08.2021.
//

import Foundation

class GitBranchesRemoteFormatter: ShellPrinter {

    func getBranchesString(_ branches: [Branch]) -> String {

        branches.enumerated().reduce("") { result, pair in

            result + "[\(pair.0 + 1)]: " + pair.1.name + "\n"
        }
    }
}
