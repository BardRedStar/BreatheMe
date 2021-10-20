//
//  MailComposerPresenter.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 19.10.2021.
//

import UIKit
import MessageUI

/// A presenter class, which is responsible for opening mail composer controller
class MailComposerPresenter: NSObject {

    // MARK: - Properties

    private var didFinish: (() -> Void)?

    /// Checks whether device can send emails (open composer) or not
    var canSendEmail: Bool {
        MFMailComposeViewController.canSendMail()
    }

    /// Opens composer controller with `attachFile` attachment. Presents modally on `presentationController`
    func present(on presentationController: UIViewController, attachFile file: URL, didFinish: @escaping (() -> Void)) {
        if !canSendEmail {
            return
        }

        self.didFinish = didFinish

        let data = try? Data(contentsOf: file)

        let controller = MFMailComposeViewController()
        controller.setToRecipients([GlobalConstants.coachEmailAddress])
        controller.mailComposeDelegate = self

        if let data = data {
            controller.addAttachmentData(data, mimeType: GlobalConstants.tempFileMimeType, fileName: GlobalConstants.tempFileName)
        }

        presentationController.present(controller, animated: true, completion: nil)
    }
}

// MARK: - MFMailComposeViewControllerDelegate

extension MailComposerPresenter: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        didFinish?()
    }
}
