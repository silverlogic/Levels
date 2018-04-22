//
//  ShareImageViewController.swift
//  Levels
//
//  Created by Shaun Bevan on 4/22/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import UIKit
import AlertTransition

final class ShareImageViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var shareImageView: UIImageView!
    var shareImage: UIImage!


    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}


// MARK: - IBActions
private extension ShareImageViewController {
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        var imageToShare = [UIImage]()
        if let image = shareImageView.image {
            imageToShare.append(image)
        }
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - AlertFrameProtocol
extension ShareImageViewController: AlertFrameProtocol {
    var alertFrame: CGRect {
        let height = UIScreen.main.bounds.height
        return CGRect(x: 0, y: UIScreen.main.bounds.height - height, width: UIScreen.main.bounds.width, height: height)
    }
}


// MARK: - Private Instance Methods
private extension ShareImageViewController {

    func setup() {
        shareImageView.image = shareImage
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
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
