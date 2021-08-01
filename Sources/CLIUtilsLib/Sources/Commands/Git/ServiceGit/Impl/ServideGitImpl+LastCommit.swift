//
//  ServideGitImpl+LastCommit.swift
//
//
//  Created by Rostyslav Druzhchenko on 01.08.2021.
//

import Foundation
import RDError
import RDFoundation

extension ServideGitImpl {

    func getLastCommit(_ branch: Branch) throws -> Commit {

        let hash = try getCommitInfoChunk(branch.name, "H")
        let name = try getCommitInfoChunk(branch.name, "an")
        let email = try getCommitInfoChunk(branch.name, "ae")
        let dateString = try getCommitInfoChunk(branch.name, "ct")
        let date = try dateFromISO8601(dateString)
        let subject = try getCommitInfoChunk(branch.name, "B")

        return Commit(hash, date, name, email, subject)
    }

    // MARK: - Private

    private func getCommitInfoChunk(
        _ branchName: String, _ chunk: String) throws -> String {

        let result = shellRunner.execute(
            "cd \(path) && git log -n 1 \(branchName) --pretty=format:%\(chunk)")
        try result.throwIfError()

        return result.stdout
    }

    private func dateFromISO8601(_ timestamp: String) throws -> Date {

        let timeInterval = TimeInterval(timestamp)
        if timeInterval == nil {
            throw RDError("Can't convert \"\(timestamp)\" to a Date object.")
        }

        return Date(timeInterval!)
    }
}

extension Date {

    init(_ timestamp: TimeInterval) {
        self.init(timeIntervalSince1970: timestamp)
    }
}
