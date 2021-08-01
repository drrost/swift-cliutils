//
//  Branch.swift
//
//
//  Created by Rostyslav Druzhchenko on 30.07.2021.
//

import Foundation

public enum BranchType {

    case local
    case remote
}

public class Branch {

    public let name: String
    public var isCurrent: Bool
    public let type: BranchType

    public init(
        _ name: String,
        _ isCurrent: Bool = false,
        _ type: BranchType = .local) {

        self.name = name
        self.isCurrent = isCurrent
        self.type = type
    }
}
