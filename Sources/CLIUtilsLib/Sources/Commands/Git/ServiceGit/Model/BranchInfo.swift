//
//  BranchInfo.swift
//
//
//  Created by Rostyslav Druzhchenko on 31.07.2021.
//

import Foundation

public class BranchInfo {

    public let branch: Branch
    public let state: BranchState

    public init(_ branch: Branch, _ state: BranchState) {
        self.branch = branch
        self.state = state
    }
}
