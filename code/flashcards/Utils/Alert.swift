//
//  Alert.swift
//  flashcards
//
//  Created by Danuja Jayasuriya on 2024-04-14.
//

import UIKit

struct Alert {
    static func showAlert(on viewController: UIViewController, title: String = "Alert", message: String, actionTitle: String = "OK", actionStyle: UIAlertAction.Style = .default, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: actionStyle) { _ in
            completion?()
        }
        alert.addAction(action)
        viewController.present(alert, animated: true)
    }
}
