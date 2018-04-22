//
//  ProgressViewController.swift
//  Levels
//
//  Created by Emanuel  Guerrero on 4/22/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import UIKit

final class ProgressViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var progressImageView: UIImageView!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi * 2 //Minus can be Direction
        rotationAnimation.duration = 3.0
        rotationAnimation.repeatCount = .infinity
        progressImageView.layer.add(rotationAnimation, forKey: nil)
    }
}
