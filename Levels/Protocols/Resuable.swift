//
//  Resuable.swift
//  Levels
//
//  Created by Emanuel  Guerrero on 4/22/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import UIKit

// MARK: - Resuable View Protocol
protocol ResuableView {
    
    // MARK: - Class Attributes
    static var reuseIdentifier: String { get }
}


// MARK: - ResuableView Default Implementation
extension ResuableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
