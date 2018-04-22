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
        progressImageView.startRotating()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        progressImageView.stopRotating()
    }
}
