//
//  SandbagCalculatorViewController.swift
//  Levels
//
//  Created by Shaun Bevan on 4/21/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import UIKit
import AlertTransition

class SandbagCalculatorViewController: UIViewController, AlertFrameProtocol {

    var alertFrame: CGRect {
        let height = UIScreen.main.bounds.width / 638 * 500
        return CGRect(x: 0, y: UIScreen.main.bounds.height - height, width: UIScreen.main.bounds.width, height: height)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
