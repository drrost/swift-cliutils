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
