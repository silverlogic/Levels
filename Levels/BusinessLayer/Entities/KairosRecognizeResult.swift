//
//  KairosRecognizeResult.swift
//  Levels
//
//  Created by Emanuel  Guerrero on 4/21/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import Foundation

// MARK: - Candidates
struct KairosCandidate: Codable {
    let confidence: Double
    let enrollmentTimestamp: String
    let faceId: String
    let subjectId: String
    
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case confidence
        case enrollmentTimestamp = "enrollment_timestamp"
        case faceId = "face_id"
        case subjectId = "subject_id"
    }
}


// MARK: - Transaction
struct KairosRecognizeTransaction: Codable {
    let confidence: Double
    let enrollmentTimestamp: String
    let eyeDistance: Int
    let faceId: String
    let galleryName: String
    let height: Int
    let pitch: Int
    let quality: Double
    let roll: Int
    let status: String
    let subjectId: String
    let topLeftX: Int
    let topLeftY: Int
    let width: Int
    let yaw: Int
    
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case confidence
        case enrollmentTimestamp = "enrollment_timestamp"
        case eyeDistance
        case faceId = "face_id"
        case galleryName = "gallery_name"
        case height
        case pitch
        case quality
        case roll
        case status
        case subjectId = "subject_id"
        case topLeftX
        case topLeftY
        case width
        case yaw
    }
}


// MARK: - Image
struct KairosRecognizeImage: Codable {
    let candidates: [KairosCandidate]
    let transaction: KairosRecognizeTransaction
}


// MARK: - Recognize Result
struct KairosRecognizeResult: Codable {
    let images: [KairosRecognizeImage]
}
