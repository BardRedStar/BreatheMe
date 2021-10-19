//
//  Errors.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 17.10.2021.
//

import Foundation

/// A custom error types related to CoreData
enum CoreDataError: LocalizedError {
    /// Error while creating an object
    case createNewObject(String)

    var errorDescription: String? {
        switch self {
        case let .createNewObject(message): return message
        }
    }
}
