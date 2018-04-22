//
//  FamilyTracker.swift
//  Levels
//
//  Created by Emanuel  Guerrero on 4/22/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import PromiseKit
import UIKit

// MARK: - Family Tracker Error
enum FamilyTrackerError: Error {
    case noFile
}

final class FamilyTracker {
    
    // MARK: - Private Instance Attributes
    private var familyMembers: [FamilyMember] = []
    
    
    // MARK: - Public Instance Attributes
    var familyMembersCount: Int { return familyMembers.count }
    
    
    // MARK: - Public Instance Methods
    func addNewFamilyMember(named: String, with image: UIImage) -> Promise<Bool> {
        return Promise { seal in
            Kairos.enrollPerson(named: named, with: image)
            .done { [weak self] (enrolled) in
                let familyMember = FamilyMember(name: named, imageUrl: nil, isMissing: true, image: image)
                self?.familyMembers.append(familyMember)
                seal.fulfill(enrolled)
            }
            .catch { (error) in
               seal.reject(error)
            }
        }
    }
    
    func recognizeFamilyMember(from image: UIImage) -> Promise<Bool> {
        return Kairos.recognizePerson(with: image)
    }
    
    func loadSavedFamilyMembers() -> Promise<Void> {
        return Promise { seal in
            guard let url = Bundle.main.url(forResource: "familymembers", withExtension: "json") else {
                seal.reject(FamilyTrackerError.noFile)
                return
            }
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let familyMembers = try decoder.decode([FamilyMember].self, from: data)
                self.familyMembers.append(contentsOf: familyMembers)
                seal.fulfill(())
            } catch {
                seal.reject(error)
            }
        }
    }
    
    func familyMember(at index: Int) -> FamilyMember? {
        return familyMembers[safe: index]
    }
}
