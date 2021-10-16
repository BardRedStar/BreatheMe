//
//  MainViewController.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 06.10.2021.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var breatheButton: MainBreatheButton!

    // MARK: - Properties

    private var viewModel: MainControllerViewModel!

    private lazy var recorder = BreatheRecorder(parentController: self)
    private lazy var processor = BreatheProcessor()

    // MARK: - Initialization

    class func instantiate(viewModel: MainControllerViewModel) -> MainViewController {
        let controller = UIStoryboard(name: "MainViewController", bundle: nil).instantiateInitialViewController() as! MainViewController
        controller.viewModel = viewModel
        return controller
    }

    // MARK: - UI Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Main"

        configureRecorder()
        configureProcessor()
    }

    // MARK: - UI Methods

    private func configureRecorder() {

        recorder.isFakeMode = true

        recorder.didRecordVolumeValue = { [weak self] value in
            self?.processor.processNewVolumeValue(value)
        }
    }

    private func configureProcessor() {
        processor.didChangeStage = { [weak self] stage in
            guard let self = self else { return }

            self.viewModel.saveBreatheStage(stage)
        }
    }

    // MARK: - UI Callbacks

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

