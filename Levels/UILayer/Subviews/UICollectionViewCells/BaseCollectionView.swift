//
//  BaseCollectionView.swift
//  Levels
//
//  Created by Emanuel  Guerrero on 4/22/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private Class Attributes
    private static var size = CGSize(width: 50.0, height: 50.0)
}


extension BaseCollectionViewCell {
    open class func itemSize() -> CGSize {
        return size
    }
}
