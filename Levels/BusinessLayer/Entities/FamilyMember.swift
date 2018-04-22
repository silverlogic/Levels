//
//  FamilyMember.swift
//  Levels
//
//  Created by Emanuel  Guerrero on 4/22/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import UIKit

struct FamilyMember: Codable {
    let name: String
    let imageUrl: URL?
    var isMissing = false
    var image: UIImage?
    
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case name
        case imageUrl
        case isMissing
    }
}
