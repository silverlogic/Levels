//
//  CircleImageView.swift
//  Levels
//
//  Created by Emanuel  Guerrero on 4/22/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import Kingfisher
import UIKit

final class CircleImageView: UIImageView {
    
    // MARK: - Lifcycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setup()
    }
}


// MARK: - Private Instance Methods
private extension CircleImageView {
    
    /// Configures the view to be a circle.
    func setup() {
        layer.cornerRadius = frame.size.width / 2
        layer.borderWidth = 2
        clipsToBounds = true
    }
}


// MARK: - Kingfisher
extension CircleImageView {
    func setImageWithUrl(_ url: URL) {
        kf.setImage(with: url)
    }
    
    /// Cancels downloading the image from the url.
    func cancelImageDownload() {
        kf.cancelDownloadTask()
    }
}
