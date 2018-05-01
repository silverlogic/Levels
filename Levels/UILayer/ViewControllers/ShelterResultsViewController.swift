//
//  ShelterResultsViewController.swift
//  Levels
//
//  Created by Shaun Bevan on 4/22/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import UIKit
import AlertTransition


final class ShelterResultsViewController: UIViewController {


    // MARK: - IBOutlets
    @IBOutlet private weak var resultImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var matchLabel: UILabel!


    // MARK: - Public Instance Attributes
    var resultStatus: Bool = false

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        setup()
    }
}


// MARK: - Private Instance Method
extension ShelterResultsViewController {

    func setup() {
        resultImageView.image = resultStatus ? UIImage(named: "icon-checkmark") : UIImage(named: "icon-nomatch")
        matchLabel.text = resultStatus ? "Located!" : "No Match"
        nameLabel.text = resultStatus ? "Manny Guerrero" : ""
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


// MARK: - AlertFrameProtocol
extension ShelterResultsViewController: AlertFrameProtocol {

    var alertFrame: CGRect {
        let height = UIScreen.main.bounds.width / 638 * 1000
        return CGRect(x: 0, y: UIScreen.main.bounds.height - height, width: UIScreen.main.bounds.width, height: height)
    }
}
