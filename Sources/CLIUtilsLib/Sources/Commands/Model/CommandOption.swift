//
//  CommandOption.swift
//
//
//  Created by Rostyslav Druzhchenko on 08.06.2021.
//

import Foundation

public class CommandOption: Equatable {

    public let symbol: String

    public let arguments: [String]

    public init(_ symbol: String, _ arguments: [String] = [String]()) {
        self.symbol = symbol
        self.arguments = arguments
    }

    var description: String {
        debugDescription
    }
    var debugDescription: String {
        "CommandOption." + symbol
    }

    // MARK: - Equatable

    public static func == (lhs: CommandOption, rhs: CommandOption) -> Bool {
        lhs.symbol == lhs.symbol
    }
}
