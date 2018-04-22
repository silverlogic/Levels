//
//  KairosEnrollTransaction.swift
//  Levels
//
//  Created by Emanuel  Guerrero on 4/21/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import Foundation

struct KairosEnrollTransaction: Codable {
    let confidence: Double
    let eyeDistance: Int
    let faceId: String
    let galleryName: String
    let height: Int
    let imageId: Int
    let pitch: Int
    let quality: Double
    let roll: Int
    let status: String
    let subjectId: String
    let timestamp: String
    let topLeftX: Int
    let topLeftY: Int
    let width: Int
    let yaw: Int
    
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case confidence
        case eyeDistance
        case faceId = "face_id"
        case galleryName = "gallery_name"
        case height
        case imageId = "image_id"
        case pitch
        case quality
        case roll
        case status
        case subjectId = "subject_id"
        case timestamp
        case topLeftX
        case topLeftY
        case width
        case yaw
    }
}
