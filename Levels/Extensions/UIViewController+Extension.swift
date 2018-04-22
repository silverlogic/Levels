//
//  UIViewController+Extension.swift
//  Levels
//
//  Created by Shaun Bevan on 4/21/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import UIKit

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
