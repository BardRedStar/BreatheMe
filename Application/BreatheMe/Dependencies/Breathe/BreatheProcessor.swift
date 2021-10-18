//
//  BreatheProcessor.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 11.10.2021.
//

import Foundation

/// A class, which processes volume and detects breathe stages
class BreatheProcessor: NSObject {

    // MARK: - Output

    var didChangeStage: ((BreatheStage) -> Void)?

    // MARK: - Properties

    private var confirmedStage: BreatheStage = .delay
    private var newStageStreak: Int = 0
    private var newSupposedStage: BreatheStage = .delay

    // MARK: - Processing methods

    func reset() {
        confirmedStage = .delay
        newStageStreak = 0
        newSupposedStage = .delay
    }

    func processNewVolumeValue(_ value: Float) {
        let stage: BreatheStage
        switch value {
        case 10..<35: stage = .inhale
        case 35...: stage = .exhale
        default: stage = .delay
        }

        if stage == confirmedStage {
            newSupposedStage = stage
            newStageStreak = 0
            return
        }

        if stage == newSupposedStage {
            newStageStreak += 1
        } else {
            newSupposedStage = stage
            newStageStreak = 1
        }

        if newStageStreak >= 3 {
            confirmedStage = newSupposedStage
            didChangeStage?(confirmedStage)
        }
    }
}
