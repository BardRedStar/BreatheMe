//
//  Recorder.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 07.10.2021.
//

import AVFoundation
import UIKit

/// A class which is responsible for recording sounds from microphone and detecting volume level
class BreatheRecorder {

    // MARK: - Output

    var didRecordVolumeValue: ((Float) -> Void)? = nil

    // MARK: - Properties

    private lazy var engine = AVAudioEngine()

    private weak var parentController: UIViewController?
    private var isPermissionGranted: Bool = false

    // MARK: - Initialization

    init(parentController: UIViewController) {
        self.parentController = parentController
    }

    // MARK: - Recording methods

    /// Checks the microphone permission and starts listening for microphone
    func startRecording() {

        requestPermissionIfNeeded()

        if isPermissionGranted {
            record()
        }
    }

    /// Stops listening for microphone
    func stopRecording() {
        if engine.isRunning {
            engine.mainMixerNode.removeTap(onBus: 0)
            engine.stop()
        }
    }

    /// Sets up the audio engine and starts audio flow from microphone
    private func record() {
        let eqNode = equalizerNode()
        engine.attach(eqNode)

        let format = engine.inputNode.inputFormat(forBus: 0)
        engine.connect(engine.inputNode, to: eqNode, format: format)
        engine.connect(eqNode, to: engine.mainMixerNode, format: format)

        engine.mainMixerNode.installTap(onBus: 0, bufferSize: 1024, format: format) { [weak self] buffer, _ in
            self?.processAudioFrame(buffer: buffer)
        }

        engine.prepare()
        try! engine.start()
    }

    /// Creates the equalizer node with high bass level and low mid and high frequencies
    /// It needs to highlight the breath bass, which happens when you breathe directly into microphone
    private func equalizerNode() -> AVAudioUnitEQ {
        let options: [(Float, Float)] = [(32, -90), (62, -80), (100, -70), (150, -60), // Low frequences
                                         (350, 24), (750, 24), (1000, 24), (2000, 24), (4000, 24), (8000, 24), (16000, 24)] // High frequences
        let eqNode = AVAudioUnitEQ(numberOfBands: options.count)
        (0..<options.count).forEach {
            eqNode.bands[$0].frequency = options[$0].0
            eqNode.bands[$0].gain = options[$0].1
        }
        return eqNode
    }

    // MARK: - Callbacks

    /// Process audio frame. Gets scaled volume level (from 0 to 100)
    private func processAudioFrame(buffer: AVAudioPCMBuffer) {
        guard let channelData = buffer.floatChannelData else {
            return
        }

        let channelDataValue = channelData.pointee
        let channelDataValueArray = stride(from: 0, to: Int(buffer.frameLength), by: buffer.stride).map { channelDataValue[$0] }

        let rms = sqrt(channelDataValueArray.map {
            return $0 * $0
        }.reduce(0, +) / Float(buffer.frameLength))

        let volumeDB = 20 * log10(rms)
        let volumeScaledValue = self.scaledPower(volumeDB)

        didRecordVolumeValue?(volumeScaledValue)
    }

    // MARK: - Utils

    /// Scales volume power and cuts the low constant noise off
    private func scaledPower(_ power: Float) -> Float {
        guard power.isFinite else {
          return 0.0
        }

        let minDb: Float = -55

        if power < minDb {
          return 0.0
        } else if power >= 1.0 {
          return 100.0
        } else {
            return 100.0 * (abs(minDb) - abs(power)) / abs(minDb)
        }
    }

    // MARK: - Permission

    /// Requests microphone permissions
    private func requestPermissionIfNeeded() {

        if isPermissionGranted {
            return
        }

        let permission = AVAudioSession.sharedInstance().recordPermission
        switch permission {
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { [weak self] granted in
                guard let self = self else { return }
                if granted {
                    self.startRecording()
                }
                self.isPermissionGranted = granted
            }
        case .denied:
            showPermissionDeniedAlert()
            isPermissionGranted = false
        case .granted:
            isPermissionGranted = true
            break
        @unknown default:
            break
        }
    }

    /// Shows the permission denied alert dialog
    private func showPermissionDeniedAlert() {
        guard let parent = parentController else { return }

        let controller = UIAlertController(title: "Alert-Microphone-Permission-Title".localized(),
                                           message: "Alert-Microphone-Permission-Message".localized(),
                                           preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Alert-Button-Cancel".localized(), style: .cancel, handler: nil))

        controller.addAction(UIAlertAction(title: "Alert-Button-Open-Settings".localized(), style: .default) { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
        })

        parent.present(controller, animated: true, completion: nil)
    }
}
