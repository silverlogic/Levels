//
//  UIView+Extension.swift
//  Levels
//
//  Created by Emanuel  Guerrero on 4/22/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import UIKit

// MARK: - Show/Hide Animation
extension UIView {
    func animateShow() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.alpha = 1
        }
    }
    
    func animateHide() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.alpha = 0
        }
    }
}


// MARK: - Drawing
extension UIView {

    /// Make snapshot of current view context with hierarchy.
    ///
    /// - Parameters:
    ///   - scale: A 'CGFloat' for scaling rendering image.
    ///            The display scale of the image renderer context.
    ///            The display scale determines the number of pixels per point.
    ///            The default value is equal to the scale of the main screen.
    ///   - afterScreenUpdates: A `Bool` that indicates whether the snapshot
    ///                         should be rendered after recent changes have
    ///                         been incorporated. Specify the value false
    ///                         if you want to render a snapshot in the view
    ///                         hierarchy’s current state, which
    ///                         might not include recent changes..
    func asImage(_ scale: CGFloat = 1.0, afterScreenUpdates: Bool = true) -> UIImage {
        let rendererFormat = UIGraphicsImageRendererFormat.default()
        rendererFormat.opaque = isOpaque
        rendererFormat.scale = scale
        let renderSize = bounds.size
        let renderer = UIGraphicsImageRenderer(size: renderSize, format: rendererFormat)
        return renderer.image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: afterScreenUpdates)
        }
    }

    /// Make snapshot of current view context with hierarchy.
    /// Could be called in the background thread.
    ///
    /// - Parameters:
    ///   - scale: A 'CGFloat' for scaling rendering image.
    ///            The display scale of the image renderer context.
    ///            The display scale determines the number of pixels per point.
    ///            The default value is equal to the scale of the main screen.
    func asImageNotThreadSafe(_ scale: CGFloat = 1.0) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, scale)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
