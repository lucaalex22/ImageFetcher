//
//  MockNetworkService.swift
//  AbiHomeTests
//
//  Created by Alexandru Luca on 06/01/2021.
//

import Foundation
@testable import AbiHome

final class MockNetworkService: NetworkService {

    enum TestingStrategy {
        case success(Data)
        case failure(NetworkError)
    }

    var strategy: TestingStrategy!

    func executeRequest<T: Request>(_ request: T, serviceOptions: NetworkServiceOptions, completion: @escaping (Result<T.Response, NetworkError>) -> Void) {
        switch strategy! {
        case .success(let data):
            do {
                let response = try JSONDecoder().decode(T.Response.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.decodingFailed))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }

}
