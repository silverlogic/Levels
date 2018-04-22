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
    @IBOutlet private weak var garageDoorSlider: VSSlider!
    @IBOutlet private weak var sandbagTotalLabel: UILabel!


    // MARK: - Private Instance Attributes
    private var sandbagTotalCount = 0


    // MARK: - Public Instance Attributes
    var surgeHeight: Double = 0
    var shareImageClosure: ((_ info: SandbagInfo) -> Void)?


    // MARK; - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}


// MARK: - IBActions
extension SandbagCalculatorViewController {
    @IBAction private func doorSlider(_ sender: VSSlider) {
        calculateBags()
    }

    @IBAction private func windowSlider(_ sender: VSSlider) {
        calculateBags()
    }

    @IBAction private func slidingDoorSlider(_ sender: VSSlider) {
        calculateBags()
    }

    @IBAction func garageDoorSlider(_ sender: VSSlider) {
        calculateBags()
    }

    @IBAction private func shareButtonTapped(_ sender: UIButton) {
        guard let closure = shareImageClosure else { return }
        dismiss(animated: true) { [weak self] in
            guard let strongSelf = self else { return }
            let info = SandbagInfo(doors: Int(strongSelf.doorsSlider.value), slidingDoors: Int(strongSelf.slidingDoorsSlider.value), windows: Int(strongSelf.windowsSlider.value), garageDoors: Int(strongSelf.garageDoorSlider.value), total: strongSelf.sandbagTotalCount)
            closure(info)
        }
    }
}


// MARK: - AlertFrameProtocol
extension SandbagCalculatorViewController: AlertFrameProtocol {
    var alertFrame: CGRect {
        let height = UIScreen.main.bounds.width / 638 * 1000
        return CGRect(x: 0, y: UIScreen.main.bounds.height - height, width: UIScreen.main.bounds.width, height: height)
    }
}


// MARK: - Private Instance Methods
private extension SandbagCalculatorViewController {

    func setup() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        sandbagTotalLabel.text = String(sandbagTotalCount)
        calculateBags()
    }

    /// Build a dike at least 1 foot higher than the projected crest level to allow for fluctuations.
    func calculateBags() {
        let height = surgeHeight + 1
        let widthOfDoors = ((Double(slidingDoorsSlider.value) * 2.0) + (Double(garageDoorSlider.value) * 2.0) + Double(doorsSlider.value)) * 4.0
        let bagsForDoors = ceil(widthOfDoors / 2.0) * ceil(height * (height + 1) / 4.0)
        let widthOfWindows = Double(windowsSlider.value) * 3.33
        let bagsForWindows = surgeHeight < 3 ? 0 : ceil(widthOfWindows / 2.0) * ceil(height * (height + 1) / 4.0)
        sandbagTotalCount = Int(bagsForDoors + bagsForWindows)
        sandbagTotalLabel.text = String(sandbagTotalCount)
    }

    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        guard let swipeGesture = gesture as? UISwipeGestureRecognizer else { return }
        switch swipeGesture.direction {
        case .down:
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
}
