//
//  GitUtil.swift
//
//
//  Created by Rostyslav Druzhchenko on 15.06.2021.
//

import Foundation
import RDError

public class GitUtil {

    // MARK: - Private

    private init() {}

    // MARK: - Public

    public static func `default`(
        _ path: String, _ shellRunner: IShellRunner) -> IGitUtil {

        GitUtilImpl(path, shellRunner)
    }
}
