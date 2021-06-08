//
//  CommandBye.swift
//
//
//  Created by Rostyslav Druzhchenko on 17.02.2021.
//

import Foundation

public class CommandBye: Command {

    public override func exec() {
        exit(0)
    }
}
