//
//  IGitUtil.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.06.2021.
//

import Foundation

protocol IGitUtil {

    init(_ path: String, _ shellRunner: IShellRunner)

    func isGitRepository() throws -> Bool

    func localFilesChanged() throws -> Int
    func localCommits(_ branch: String) throws -> Int
    func remoteCommits(_ branch: String) throws -> Int
    func branchName() throws -> String

    func getRepositoryState() throws -> GitRepositoryState

    func branchHasRemote(_ name: String) throws -> Bool
}

extension IGitUtil {

    func getRepositoryState() throws -> GitRepositoryState {

        let isRepository = try isGitRepository()
        if !isRepository {
            return GitRepositoryState(isRepository, 0, 0, 0, "")
        }

        let changes = try localFilesChanged()
        let branch = try branchName()

        let branchHasRemote = try branchHasRemote(branch)

        let localCommits = branchHasRemote ? try localCommits(branch) : 0
        let remoteCommits = branchHasRemote ? try remoteCommits(branch) : 0

        return GitRepositoryState(
            isRepository, changes, localCommits, remoteCommits, branch)
    }
}
