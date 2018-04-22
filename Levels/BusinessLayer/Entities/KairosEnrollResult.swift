//
//  KairosEnrollResult.swift
//  Levels
//
//  Created by Emanuel  Guerrero on 4/21/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import Foundation

struct KairosEnrollResult: Codable {
    let faceId: String
    let images: [KairosEnrollImage]
    
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case faceId = "face_id"
        case images
    }
}
