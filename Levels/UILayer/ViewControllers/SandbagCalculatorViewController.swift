//
//  SandbagCalculatorViewController.swift
//  Levels
//
//  Created by Shaun Bevan on 4/21/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import UIKit
import AlertTransition
import VerticalSteppedSlider

class SandbagCalculatorViewController: UIViewController, AlertFrameProtocol {

    // MARK: - IBOutlets
    @IBOutlet private weak var doorsSlider: VSSlider!
    @IBOutlet private weak var windowsSlider: VSSlider!
    @IBOutlet private weak var slidingDoorsSlider: VSSlider!


    var alertFrame: CGRect {
        let height = UIScreen.main.bounds.width / 638 * 836
        return CGRect(x: 0, y: UIScreen.main.bounds.height - height, width: UIScreen.main.bounds.width, height: height)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
