//
//  GitRepositoryState.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.06.2021.
//

import Foundation

class GitRepositoryState {

    let isGitRepository: Bool
    let localFilesChanged: Int
    let localCommits: Int
    let remoteCommits: Int
    let branch: String

    init(_ isGitRepository: Bool,
         _ localFilesChanged: Int,
         _ localCommits: Int,
         _ remoteCommits: Int,
         _ branch: String) {

        self.isGitRepository = isGitRepository
        self.localFilesChanged = localFilesChanged
        self.localCommits = localCommits
        self.remoteCommits = remoteCommits
        self.branch = branch
    }
}
