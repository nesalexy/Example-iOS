//
//  BaseViewInput.swift
//  code-example
//
//  Created by Alexy Nesterchuk on 17.07.2024.
//

import Foundation
import UIKit


protocol BaseViewInput: AnyObject {
    func showLoading()
    func hideLoading()
    func showAlert(title: String?, message: String?, actions: [UIAlertAction])
}

extension BaseViewInput {
    func showAlert(title: String? = "", message: String? = nil, actions: [UIAlertAction] = []) {
        showAlert(title: title, message: message, actions: actions)
    }
}
