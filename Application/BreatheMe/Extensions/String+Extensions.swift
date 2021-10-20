//
//  String+Extensions.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 06.10.2021.
//

import Foundation

// MARK: - Localization

extension String {

    /// Gets localized string by current string key
    func localized() -> String {
        NSLocalizedString(self, comment: "")
    }

    /// Gets argumented localized string by current string key
    func localizedWith(arguments: CVarArg...) -> String {
        String(format: localized(), arguments)
    }
}
