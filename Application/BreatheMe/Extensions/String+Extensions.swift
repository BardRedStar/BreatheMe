//
//  String+Extensions.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 06.10.2021.
//

import Foundation

// MARK: - Localization

extension String {

    func localized() -> String {
        NSLocalizedString(self, comment: "")
    }

    func localizedWith(arguments: CVarArg...) -> String {
        String(format: NSLocalizedString(self, comment: ""), arguments)
    }

}