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
        case .delay: return "Share-Breathe-Type-Delay".localized()
        case .exhale: return "Share-Breathe-Type-Exhale".localized()
        case .inhale: return "Share-Breathe-Type-Inhale".localized()
        }
    }
}
