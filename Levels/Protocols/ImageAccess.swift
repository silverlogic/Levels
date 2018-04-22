//
//  ImageAccess.swift
//  Levels
//
//  Created by Emanuel  Guerrero on 4/22/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import Foundation

protocol ImageAccess {
    
    // MARK: - Public Instance Methods
    func setImageWithUrl(_ url: URL)
    func cancelImageDownload()
}
