//
//  UICollectionView+Extension.swift
//  Levels
//
//  Created by Emanuel  Guerrero on 4/22/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import UIKit

// MARK: - ResuableView
extension UICollectionViewCell: ResuableView {}


// MARK: - UICollectionView Dequeue
extension UICollectionView {
    func dequeueCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        let identifier = T.reuseIdentifier
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Could Not Dequeue Cell With Identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}
