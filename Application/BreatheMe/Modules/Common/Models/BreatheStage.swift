//
//  BreatheStage.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 13.10.2021.
//

/// Possible breathe stages
enum BreatheStage: String {
    case inhale, exhale, delay

    /// A string representing stage on UI
    var presentationString: String {
        switch self {
        case .delay: return "Breathe delay"
        case .exhale: return "Exhale"
        case .inhale: return "Inhale"
        }
    }
}
