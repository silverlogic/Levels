//
//  KairosAttributes.swift
//  Levels
//
//  Created by Emanuel  Guerrero on 4/21/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import Foundation

// MARK: - Gender
struct KairosGender: Codable {
    let femaleConfidence: Double
    let maleConfidence: Double
    let type: String
}


// MARK: - Attributes
struct KairosAttributes: Codable {
    let age: Int
    let asian: Double
    let black: Double
    let gender: KairosGender
    let glasses: String
    let hispanic: Double
    let lips: String
    let other: Double
    let white: Double
}
