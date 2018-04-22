//
//  UIViewController+Extension.swift
//  Levels
//
//  Created by Shaun Bevan on 4/21/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import UIKit
import UITextField_Shake

// MARK: - Public Class Methods
extension UIViewController {

    /// The storyboard identifier used.
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}


// MARK: - Public Instance Methods For UIActivityIndicatorView
extension UIViewController {
    func showActivityIndicator() {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.color = .darkTeal
        activityIndicatorView.tag = 99
        activityIndicatorView.center = view.center
        activityIndicatorView.alpha = 0
        activityIndicatorView.startAnimating()
        view.addSubview(activityIndicatorView)
        activityIndicatorView.animateShow()
    }
    
    func dismissActivityIndicator() {
        guard let activityIndicatorView = view.subviews.first(where: { $0.tag == 99 }) else { return }
        activityIndicatorView.animateHide()
        activityIndicatorView.removeFromSuperview()
    }
}


// MARK: - Public Instance Methods For SCLAlertView
extension UIViewController {
    func showErrorAlert(title: String, subTitle: String) {
        let alert = BaseAlertViewController(shouldAutoDismiss: true, shouldShowCloseButton: false)
        alert.showErrorAlert(title: title, subtitle: subTitle)
    }
    
    func showErrorAlert(title: String,
                        subtitle: String,
                        buttonAttributes: [AlertButtonAttributes],
                        _ showCancelButton: Bool = false) {
        let alert = BaseAlertViewController(shouldAutoDismiss: false, shouldShowCloseButton: false)
        buttonAttributes.forEach {
            let handler = $0.handler
            alert.addActionButton(title: $0.title) {
                alert.hideView()
                handler()
            }
        }
        if showCancelButton {
            let cancelTitle = "Cancel"
            alert.addActionButton(title: cancelTitle) {
                alert.hideView()
            }
        }
        alert.showErrorAlert(title: title, subtitle: subtitle)
    }
    
    func showInfoAlert(title: String, subTitle: String) {
        let alert = BaseAlertViewController(shouldAutoDismiss: true, shouldShowCloseButton: false)
        alert.showInfoAlert(title: title, subtitle: subTitle)
    }
    
    func showInfoAlert(title: String,
                       subTitle: String,
                       buttonName: String,
                       _ showCancelButton: Bool = false,
                       handler: @escaping () -> Void) {
        let alert = BaseAlertViewController(
            shouldAutoDismiss: false,
            shouldShowCloseButton: false
        )
        alert.addActionButton(title: buttonName) {
            handler()
            alert.hideView()
        }
        if showCancelButton {
            let cancelTitle = "Cancel"
            alert.addActionButton(title: cancelTitle) {
                alert.hideView()
            }
        }
        alert.showInfoAlert(title: title, subtitle: subTitle)
    }
    
    func showEditAlert(title: String,
                       subtitle: String,
                       textFieldAttributes: [AlertTextFieldAttributes],
                       submitButtonTapped: @escaping (_ enteredValues: [String: String]) -> Void) {
        let alert = BaseAlertViewController(shouldAutoDismiss: false, shouldShowCloseButton: false)
        if textFieldAttributes.isEmpty { return }
        var textFields = [UITextField]()
        textFieldAttributes.forEach { textFields.append(alert.addTextField(textfieldAttributes: $0)) }
        alert.addActionButton(title: "Submit") {
            textFields.forEach { $0.resignFirstResponder() }
            let emptyTextFields = textFields.filter { ($0.text?.isEmpty)! }
            if !emptyTextFields.isEmpty {
                emptyTextFields.forEach { $0.shake() }
                return
            }
            var enteredValues = [String: String]()
            textFields.forEach { enteredValues[$0.placeholder!] = $0.text }
            alert.hideView()
            submitButtonTapped(enteredValues)
        }
        alert.addActionButton(title: "Cancel") {
            textFields.forEach { $0.resignFirstResponder() }
            alert.hideView()
        }
        alert.showEditAlert(title: title, subtitle: subtitle)
    }
}
