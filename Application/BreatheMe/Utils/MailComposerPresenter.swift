//
//  MailComposerPresenter.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 19.10.2021.
//

import UIKit
import MessageUI

class MailComposerPresenter {

    func present(on presentationController: UIViewController, attachFile file: URL) {
        if !MFMailComposeViewController.canSendMail() {
            return
        }

        let data = try? Data(contentsOf: file)

        let controller = MFMailComposeViewController()
        controller.setToRecipients([GlobalConstants.coachEmailAddress])
        controller.addAttachmentData(data ?? Data(), mimeType: "text/plain", fileName: "yoga_training.txt")
        presentationController.present(controller, animated: true, completion: nil)
    }
}
