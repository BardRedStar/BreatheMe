//
//  BreatheProcessor.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 11.10.2021.
//

import Foundation

protocol BreatheProcessorDelegate: AnyObject {
    func breatheProcessor(_ processor: BreatheProcessor, didChangeStageTo stage: BreatheProcessor.Stage)
}

/// A class, which processes volume and detects breathe stages
class BreatheProcessor: NSObject {

    enum Stage {
        case inhale, exhale
    }

    private var threshold: Int = 0

    func processNewVolumeValue(_ value: Double) {
        print(value)
    }

}
