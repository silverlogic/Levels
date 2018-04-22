//
//  NetworkService.swift
//  Levels
//
//  Created by Emanuel  Guerrero on 4/21/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import Alamofire
import CodableAlamofire
import Foundation
import PromiseKit

// MARK: - Network Errors
enum NetworkError: Error {
    case parse
}


// MARK: - Request Object
struct RequestInfo {
    let url: URL
    let method: HTTPMethod
    let Parameters: Parameters?
    let headers: HTTPHeaders?
    let encoding: ParameterEncoding
}


// MARK: - Network Service
final class NetworkService {
    func perform<T: Codable>(with requestInfo: RequestInfo) -> Promise<T> {
        return Promise<T> { seal in
            Alamofire.request(
                requestInfo.url,
                method: requestInfo.method,
                parameters: requestInfo.Parameters,
                encoding: requestInfo.encoding,
                headers: requestInfo.headers
            )
            .responseDecodableObject { (response: DataResponse<T>) in
                guard response.error == nil else {
                    seal.reject(response.error!)
                    return
                }
                guard let value = response.result.value else {
                    seal.reject(NetworkError.parse)
                    return
                }
                seal.fulfill(value)
            }
        }
    }
}
