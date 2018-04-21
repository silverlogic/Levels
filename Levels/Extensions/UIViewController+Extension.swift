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
