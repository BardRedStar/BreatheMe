//
//  MainViewController.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 06.10.2021.
//

import UIKit
import Reusable

class MainViewController: UIViewController, StoryboardBased {

    // MARK: - Outlets

    @IBOutlet private weak var breatheButton: MainBreatheButton!

    // MARK: - Properties

    private var viewModel: MainControllerViewModel!

    private lazy var recorder = Recorder(parentController: self)

    // MARK: - Initialization

    class func instantiate(viewModel: MainControllerViewModel) -> MainViewController {
        let controller = MainViewController.instantiate()
        controller.viewModel = viewModel
        return controller
    }

    // MARK: - UI Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Main"
    }


    @IBAction private func breatheAction(_ sender: Any) {
        if viewModel.isBreathing {
            print("Stop breathing")
            recorder.stopRecording()
        } else {
            print("Breathe")
            recorder.startRecording()
        }
        viewModel.isBreathing.toggle()
    }
}

