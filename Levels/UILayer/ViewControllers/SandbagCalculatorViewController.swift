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

final class SandbagCalculatorViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var doorsSlider: VSSlider!
    @IBOutlet private weak var windowsSlider: VSSlider!
    @IBOutlet private weak var slidingDoorsSlider: VSSlider!
    @IBOutlet private weak var sandbagTotalLabel: UILabel!

    // MARK: - Private Instance Attributes


    // MARK; - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


// MARK: - IBActions
extension SandbagCalculatorViewController {
    @IBAction func doorSlider(_ sender: VSSlider) {
    }

    @IBAction func windowSlider(_ sender: VSSlider) {
    }

    @IBAction func slidingDoorSlider(_ sender: VSSlider) {
    }

    @IBAction func shareButtonTapped(_ sender: UIButton) {
    }
}


// MARK: - AlertFrameProtocol
extension SandbagCalculatorViewController: AlertFrameProtocol {
    var alertFrame: CGRect {
        let height = UIScreen.main.bounds.width / 638 * 836
        return CGRect(x: 0, y: UIScreen.main.bounds.height - height, width: UIScreen.main.bounds.width, height: height)
    }
}
