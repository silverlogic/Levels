//
//  UIView+Extension.swift
//  Levels
//
//  Created by Emanuel  Guerrero on 4/22/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import UIKit

extension UIView {
    func startRotating(duration: Double = 1) {
        let kAnimationKey = "rotation"
        if self.layer.animation(forKey: kAnimationKey) == nil {
            let animate = CABasicAnimation(keyPath: "transform.rotation")
            animate.duration = duration
            animate.repeatCount = Float.infinity
            animate.fromValue = 0.0
            animate.toValue = Float(Float.pi * 2.0)
            self.layer.add(animate, forKey: kAnimationKey)
        }
    }
    func stopRotating() {
        let kAnimationKey = "rotation"
        if self.layer.animation(forKey: kAnimationKey) != nil {
            self.layer.removeAnimation(forKey: kAnimationKey)
        }
    }
}

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


extension UIView {

    /// Performs an animation for changing the root view controller of the application.
    ///
    /// - Parameter snapshot: A `UIView` representing the snapshot of the current window to apply the
    ///                       animation.
    static func performRootViewControllerAnimation(snapshot: UIView) {
        UIView.animate(withDuration: 0.3, animations: {() in
            snapshot.layer.opacity = 0
            snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
        }, completion: { _ in
            snapshot.removeFromSuperview()
        })
    }
}
