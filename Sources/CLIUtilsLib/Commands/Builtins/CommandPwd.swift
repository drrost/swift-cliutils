//
//  CommandPwd.swift
//
//
//  Created by Rostyslav Druzhchenko on 17.02.2021.
//

import Foundation

public class CommandPwd: Command {

    public convenience init() {
        self.init("", [])
    }

    public override func exec() {
        System.out.println(pwd())
    }

    public func pwd() -> String {
        shellRunner.execute("pwd").output().trimN()
    }
}
