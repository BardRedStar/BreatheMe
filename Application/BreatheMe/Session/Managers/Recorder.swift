//
//  Recorder.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 07.10.2021.
//

import AVFoundation
import UIKit

class Recorder {

    // MARK: - Output

    var didCancelPermissionAlert: (() -> Void)? = nil

    // MARK: - Properties

    private var recorder: AVAudioRecorder!

    private weak var parentController: UIViewController?
    private var isPermissionGranted: Bool = false

    private var audioMetricsTimer: Timer? = nil

    // MARK: - Initialization

    init(parentController: UIViewController) {
        self.parentController = parentController
    }

    // MARK: - Recording methods
    private func startRecording() {
        requestPermissionIfNeeded()

        if isPermissionGranted {
            record()
        }
    }

    private func record() {
        let cacheFolder = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let url = cacheFolder.appendingPathComponent("breathe_me_record.caf")

        let recordSettings: [String: Any] = [
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 2,
            AVEncoderBitRateKey: 12800,
            AVLinearPCMBitDepthKey: 16,
            AVFormatIDKey: kAudioFormatAppleIMA4,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
        ]

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setActive(true)
            try recorder = AVAudioRecorder(url: url, settings: recordSettings)

        } catch {
            return
        }

        recorder.isMeteringEnabled = true
        recorder.record()

        audioMetricsTimer?.invalidate()
        audioMetricsTimer? = Timer.scheduledTimer(timeInterval: 0.02,
                                                  target: self,
                                                  selector: #selector(metricsTimerTick),
                                                  userInfo: nil,
                                                  repeats: true)
    }

    @objc private func metricsTimerTick() {
        recorder.updateMeters()

        let level = recorder.averagePower(forChannel: 0)
        print("Noise level is: \(level)")

    }

    // MARK: - Permission

    private func requestPermissionIfNeeded() {

        if isPermissionGranted {
            return
        }

        let permission = AVAudioSession.sharedInstance().recordPermission
        switch permission {
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { [weak self] granted in
                guard let self = self else { return }

                if !granted {
                    self.showPermissionDeniedAlert()
                } else {
                    self.isPermissionGranted = true
                    self.startRecording()
                }
            }
        case .denied:
            showPermissionDeniedAlert()
        case .granted:
            break
        @unknown default:
            break
        }
    }

    private func showPermissionDeniedAlert() {
        guard let parent = parentController else { return }

        let controller = UIAlertController(title: "Microphone permission denied",
                                           message: "You've denied the microphone permission. App can't hear your breathe, so, please, go to settings and enable permission from there.",
                                           preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
            self?.didCancelPermissionAlert?()
        })

        controller.addAction(UIAlertAction(title: "Open Settings", style: .default) { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
        })

        parent.present(controller, animated: true, completion: nil)
    }
}
