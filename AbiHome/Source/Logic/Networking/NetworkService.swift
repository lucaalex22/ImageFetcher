//
//  NetworkService.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import Alamofire

enum NetworkError: Error {
    case generalError
    case noData
    case decodingFailed
}

protocol NetworkService {
    func executeRequest<T: Request>(_ request: T, serviceOptions: NetworkServiceOptions, completion: @escaping (Result<T.Response, NetworkError>) -> Void)
}

final class NetworkServiceImpl: NetworkService {

    private let session: Session

    init(session: Session = .default) {
        self.session = session
    }

    func executeRequest<T: Request>(_ request: T, serviceOptions: NetworkServiceOptions, completion: @escaping (Result<T.Response, NetworkError>) -> Void) {
        session.request(serviceOptions.baseURL.appendingPathComponent(request.path),
                        method: request.method,
                        headers: HTTPHeaders(request.headers ?? [:]))
            .validate()
            .response { response in
                if response.error != nil {
                    completion(.failure(.generalError))
                    return
                }

                guard let data = response.data else {
                    completion(.failure(.noData))
                    return
                }

                do {
                    let result = try JSONDecoder().decode(T.Response.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingFailed))
                }
            }
    }

}
