//
//  CommandArguments.swift
//
//
//  Created by Rostyslav Druzhchenko on 08.06.2021.
//

import Foundation

// Basd on https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap12.html
//
public class CommandArguments {

    /// A name of a command.
    public let name: String

    /// One `-` marked arguments, consist of letters or digits.
    /// Also known as `flags`.
    public let options: [CommandOption]

    /// Arguments that follow options.
    public let operands: [String]

    public init(_ line: String) {

        let arguments = line.split(" ")

        name = arguments.count > 0 ? arguments[0] : ""

        options = Self.fetchOptions(arguments)
        operands = Self.fetchOperands(arguments)
    }

    // MARK: - Private

    private static func fetchOptions(
        _ allArguments: [String]) -> [CommandOption] {

        var arguments = allArguments
        if arguments.count < 2 {
            return [CommandOption]()
        }

        arguments.remove(at: 0)

        let optionCandidates: [String] = arguments.filter { $0.hasPrefix("-") }.map {
            String($0.dropFirst(1))
        }
        let joined = optionCandidates.joined()
        let characterSet = Set<String>.init(joined.map { String($0) })

        let options = characterSet.map { CommandOption($0) }

        return [CommandOption](options)
    }

    private static func fetchOperands(_ allArguments: [String]) -> [String] {

        var arguments = allArguments
        if arguments.count < 2 {
            return [String]()
        }

        arguments.remove(at: 0)

        arguments = arguments.filter { !$0.hasPrefix("-") }

        return arguments
    }
}
