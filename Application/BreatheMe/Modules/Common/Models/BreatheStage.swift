//
//  BreatheStage.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 13.10.2021.
//

enum BreatheStage: String {
    case inhale, exhale, delay

    var presentationString: String {
        switch self {
        case .delay: return "Breathe delay"
        case .exhale: return "Exhale"
        case .inhale: return "Inhale"
        }
    }
}
