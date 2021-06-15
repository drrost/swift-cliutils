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
    func localCommits() throws -> Int
    func remoteCommits() throws -> Int
    func branchName() throws -> String

    func getRepositoryState() throws -> GitRepositoryState
}

extension IGitUtil {

    func getRepositoryState() throws -> GitRepositoryState {

        let isRepository = try isGitRepository()
        let changes = try localFilesChanged()
        let localCommits = try localCommits()
        let remoteCommits = try remoteCommits()
        let branch = try branchName()

        return GitRepositoryState(
            isRepository, changes, localCommits, remoteCommits, branch)
    }
}
