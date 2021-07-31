//
//  GitRepositoryState.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.06.2021.
//

import Foundation

public class GitRepositoryState {

    public let isValidGitRepository: Bool
    public let branchInfo: BranchInfo

    public init(
        _ isValidGitRepository: Bool,
        _ branchInfo: BranchInfo) {

        self.isValidGitRepository = isValidGitRepository
        self.branchInfo = branchInfo
    }

    public convenience init(
        _ isValidGitRepository: Bool,
        _ localFilesChanged: Int,
        _ localCommits: Int,
        _ remoteCommits: Int,
        _ name: String) {

        let branch = Branch(name)
        let state = BranchState(localFilesChanged, localCommits, remoteCommits)
        let info = BranchInfo(branch, state)

        self.init(isValidGitRepository, info)
    }
}
