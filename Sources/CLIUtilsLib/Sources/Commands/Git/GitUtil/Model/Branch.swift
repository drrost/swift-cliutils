//
//  Branch.swift
//
//
//  Created by Rostyslav Druzhchenko on 30.07.2021.
//

import Foundation

class Branch {

    let name: String
    var isCurrent: Bool

    init(_ name: String, _ isCurrent: Bool = false) {
        self.name = name
        self.isCurrent = isCurrent
    }
}

class BranchState {

    let localFilesChanged: Int
    let localCommits: Int
    let remoteCommits: Int

    init(_ localFilesChanged: Int, _ localCommits: Int, _ remoteCommits: Int) {
        self.localFilesChanged = localFilesChanged
        self.localCommits = localCommits
        self.remoteCommits = remoteCommits
    }
}

class BranchInfo {

    let branch: Branch
    let state: BranchState

    init(_ branch: Branch, _ state: BranchState) {
        self.branch = branch
        self.state = state
    }
}
