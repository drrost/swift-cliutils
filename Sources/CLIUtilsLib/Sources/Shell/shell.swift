//
//  shell.swift
//
//
//  Created by Rostyslav Druzhchenko on 17.02.2021.
//

import Foundation

public func shell(_ command: String) -> ShellResult {

    let task = Process()
    let pipeStdout = Pipe()
    let pipeStderr = Pipe()

    task.standardOutput = pipeStdout
    task.standardError = pipeStderr
    task.arguments = ["-c", command]
    task.launchPath = "/bin/zsh"
    task.launch()
    task.waitUntilExit()

    // ?? handle output in realteime

    let outdata = pipeStdout.fileHandleForReading.readDataToEndOfFile()
    let stdout = String(data: outdata, encoding: .utf8)!

    let errdata = pipeStderr.fileHandleForReading.readDataToEndOfFile()
    let stderr = String(data: errdata, encoding: .utf8)!

    let exitCode = Int(task.terminationStatus)
    return ShellResult(stdout, stderr, exitCode)
}
