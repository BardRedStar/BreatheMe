//
//  MainControllerViewModel.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 06.10.2021.
//

import Foundation

class MainControllerViewModel {

    let session: AppSession

    var isBreathing: Bool = false

    init(session: AppSession) {
        self.session = session
    }

    func saveBreatheStage(_ stage: BreatheStage) {
        
        print(stage)
    }
}
