//
//  CommandUnknown.swift
//
//
//  Created by Rostyslav Druzhchenko on 17.02.2021.
//

import Foundation

public class CommandUnknown: Command {

    public override func exec() {
        System.err.println("Unknown command `" + name + "'\n" +
                            "Run `help' to see the supported commands list")
    }
}
