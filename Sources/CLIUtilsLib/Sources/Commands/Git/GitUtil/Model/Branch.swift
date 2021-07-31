//
//  Branch.swift
//
//
//  Created by Rostyslav Druzhchenko on 30.07.2021.
//

import Foundation

public class Branch {

    public let name: String
    public var isCurrent: Bool

    public init(_ name: String, _ isCurrent: Bool = false) {
        self.name = name
        self.isCurrent = isCurrent
    }
}
