//
//  Request.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import Alamofire
import Foundation

protocol Request {
    associatedtype Response: Decodable
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var path: String { get }
}

extension Request {

    var method: HTTPMethod { .get }
    var headers: [String: String]? { nil }

}
