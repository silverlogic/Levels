//
//  MyFriendCollectionViewLayout.swift
//  Levels
//
//  Created by Emanuel  Guerrero on 4/22/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import UIKit

final class MyFriendCollectionViewLayout: UICollectionViewFlowLayout {
    // MARK: - Public Instance Attributes
    var numberOfItemsPerRow: Int = 2 {
        didSet {
            invalidateLayout()
        }
    }
    
    
    // MARK: - Lifecycle
    override func prepare() {
        super.prepare()
        guard let currentCollectionView = collectionView else { return }
        scrollDirection = .vertical
        var newItemSize = itemSize
        let itemsPerRow = CGFloat(max(numberOfItemsPerRow, 1))
        let totalSpacingBetweenCells = minimumInteritemSpacing * (itemsPerRow - 1.0)
        newItemSize.width = (currentCollectionView.bounds.size.width - totalSpacingBetweenCells) / itemsPerRow
        if itemSize.height > 0 {
            let itemAspectRatio = itemSize.width / itemSize.height
            newItemSize.height = newItemSize.width / itemAspectRatio
        }
        itemSize = newItemSize
    }
}
