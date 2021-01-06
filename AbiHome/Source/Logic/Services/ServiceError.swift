//
//  ServiceError.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import Foundation

enum ServiceError: Error {
    case requestFailed

    var message: String {
        switch self {
        case .requestFailed: return "Something went wrong. Please try again."
        }
    }

}

extension ServiceError {

    // Can be improved, depending on UX cases.
    static func error(from networkError: NetworkError) -> ServiceError {
        return .requestFailed
    }

}
