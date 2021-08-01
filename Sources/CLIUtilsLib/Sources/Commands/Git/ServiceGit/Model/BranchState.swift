//
//  BranchState.swift
//
//
//  Created by Rostyslav Druzhchenko on 31.07.2021.
//

import Foundation

public class BranchState {

    public let localFilesChanged: Int
    public let localCommits: Int
    public let remoteCommits: Int

    public init(
        _ localFilesChanged: Int, _ localCommits: Int, _ remoteCommits: Int) {

        self.localFilesChanged = localFilesChanged
        self.localCommits = localCommits
        self.remoteCommits = remoteCommits
    }
}
