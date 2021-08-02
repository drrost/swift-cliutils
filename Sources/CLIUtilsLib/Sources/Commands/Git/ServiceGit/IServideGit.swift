//
//  IServideGit.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.06.2021.
//

import Foundation
import RDDI

public protocol IServideGit: IDependency {

    init(_ path: String, _ shellRunner: IShellRunner)

    func isValidGitRepository() throws -> Bool

    func localFilesChanged() throws -> Int
    func localCommits(_ branch: String) throws -> Int
    func remoteCommits(_ branch: String) throws -> Int
    func branchName() throws -> String

    func getRepositoryState() throws -> GitRepositoryState

    func branchHasRemote(_ name: String) throws -> Bool

    func localBranches() throws -> [Branch]
    func remoteBranches() throws -> [Branch]
    func getInfo(for branches: [Branch]) throws -> [BranchInfo]
    func switchTo(_ branch: Branch) throws
    func getLastCommit(_ branch: Branch) throws -> Commit
}

public extension IServideGit {

    func getRepositoryState() throws -> GitRepositoryState {

        let isRepository = try isValidGitRepository()
        if !isRepository {
            return GitRepositoryState(isRepository, BranchInfo.empty())
        }

        let changes = try localFilesChanged()
        let name = try branchName()

        let branchHasRemote = try branchHasRemote(name)

        let localCommits = branchHasRemote ? try localCommits(name) : 0
        let remoteCommits = branchHasRemote ? try remoteCommits(name) : 0

        let branch = Branch(name)
        let state = BranchState(changes, localCommits, remoteCommits)
        let branchInfo = BranchInfo(branch, state)

        return GitRepositoryState(isRepository, branchInfo)
    }
}

fileprivate extension BranchInfo {

    static func empty() -> BranchInfo {
        let branch = Branch("")
        let state = BranchState(0, 0, 0)
        return BranchInfo(branch, state)
    }
}

fileprivate extension Commit {

    static func empty() -> Commit {
        Commit("", Date(), "", "", "")
    }
}
