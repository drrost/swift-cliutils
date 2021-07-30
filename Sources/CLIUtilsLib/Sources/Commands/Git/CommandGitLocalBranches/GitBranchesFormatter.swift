//
//  GitBranchesFormatter.swift
//
//
//  Created by Rostyslav Druzhchenko on 30.07.2021.
//

import Foundation

class ShellPrinter {

    func addColor(_ candidate: String, _ color: String) -> String {
        color + candidate + .NC
    }
}

fileprivate extension String {

    static let RED: String     = "\u{001B}[0;31m"
    static let GREEN: String   = "\u{001B}[0;32m"
    static let YELLOW: String  = "\u{001B}[0;33m"
    static let MAGENTA: String = "\u{001B}[0;35m"

    static let NC: String = "\u{001B}[0m"
}

class GitBranchesFormatter: ShellPrinter {

    func getBranchesString(_ branchInfos: [BranchInfo]) -> String {

        branchInfos.enumerated().reduce("") { result, pair in

            let stateString = pair.1.state.toString()
            var line = "[\(pair.0 + 1)]: " + pair.1.branch.name + " " + stateString
            if pair.1.branch.isCurrent {
                line = addColor(line, .GREEN)
            }
            line += " \n"
            return result + line
        }
    }
}
