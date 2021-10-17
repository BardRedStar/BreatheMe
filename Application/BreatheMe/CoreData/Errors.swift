//
//  Errors.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 17.10.2021.
//

import Foundation

enum CoreDataError: LocalizedError {
    case createNewObject(String)

    var errorDescription: String? {
        switch self {
        case let .createNewObject(message): return message
        default: return nil
        }
    }
}
