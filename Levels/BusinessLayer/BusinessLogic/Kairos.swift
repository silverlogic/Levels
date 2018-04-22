//
//  Kairos.swift
//  Levels
//
//  Created by Emanuel  Guerrero on 4/21/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import Foundation
import PromiseKit

// MARK: - Private Constants For Kairos Keys
private let appId = "d34682d5"
private let key = "8cd09afbc87b6d59faa5c272a86f793b"


// MARK: - Kairos Errors
enum KairosError: Error {
    case badImage
}


// MARK: - Kairos Integration
final class Kairos {
    
    // MARK: - Private Instance Attributes For Kairos API Endpoints
    private enum Endpoints {
        case enroll
        case recognize
        
        func endpoint() -> String {
            let baseUrl = "https://api.kairos.com/"
            switch self {
            case .enroll:
                return "\(baseUrl)enroll"
            case .recognize:
                return "\(baseUrl)recognize"
            }
        }
    }
    
    
    // MARK: - Initializers
    @available(*, unavailable)
    init() {}
    
    
    // MARK: - Public Class Methods
    static func enrollPerson(named: String, with image: UIImage) -> Promise<Bool> {
        return Promise { seal in
            guard let imageData = UIImageJPEGRepresentation(image, 0.7) else {
                seal.reject(KairosError.badImage)
                return
            }
            let baseString = imageData.base64EncodedString(options: .lineLength64Characters)
            let endpoint = Endpoints.enroll.endpoint()
            let parameters: [String: Any] = [
                "image": baseString,
                "gallery_name": "missing-persons",
                "subject_id": named
            ]
            let headers: [String: String] = [
                "app_id": appId,
                "app_key": key
            ]
            let url = URL(string: endpoint)!
            let requestInfo = RequestInfo(
                url: url,
                method: .post,
                Parameters: parameters,
                headers: headers,
                encoding: .json
            )
            let networkService = NetworkService()
            networkService.perform(with: requestInfo)
            .done { (result: KairosEnrollResult) in
                guard let image = result.images.first else {
                    seal.fulfill(false)
                    return
                }
                let status = image.transaction.status
                seal.fulfill(status == "success")
            }
            .catch { (error) in
                seal.reject(error)
            }
        }
    }
    
    static func recognizePerson(with image: UIImage) -> Promise<Bool> {
        return Promise { seal in
            guard let imageData = UIImageJPEGRepresentation(image, 0.7) else {
                seal.reject(KairosError.badImage)
                return
            }
            let baseString = imageData.base64EncodedString(options: .lineLength64Characters)
            let endpoint = Endpoints.enroll.endpoint()
            let parameters: [String: Any] = [
                "image": baseString,
                "gallery_name": "missing-persons"
            ]
            let headers: [String: String] = [
                "app_id": appId,
                "app_key": key
            ]
            let url = URL(string: endpoint)!
            let requestInfo = RequestInfo(
                url: url,
                method: .post,
                Parameters: parameters,
                headers: headers,
                encoding: .json
            )
            let networkService = NetworkService()
            networkService.perform(with: requestInfo)
            .done { (result: KairosRecognizeResult) in
                guard let image = result.images.first else {
                    seal.fulfill(false)
                    return
                }
                let status = image.transaction.status
                seal.fulfill(status == "success")
            }
            .catch { (error) in
                seal.reject(error)
            }
        }
    }
}
