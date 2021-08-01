//
//  Commit.swift
//
//
//  Created by Rostyslav Druzhchenko on 01.08.2021.
//

import Foundation

public class Commit {

    public let sha: String
    public let date: Date
    public let author: String
    public let email: String
    public let subject: String

    public init(
        _ sha: String,
        _ date: Date,
        _ author: String,
        _ email: String,
        _ subject: String) {

        self.sha = sha
        self.date = date
        self.author = author
        self.email = email
        self.subject = subject
    }
}
