//
//  ImagesService.swift
//  AbiHome
//
//  Created by Alexandru Luca on 05/01/2021.
//

import Foundation

protocol ImagesService {
    func getImages(completion: @escaping ((Result<[ImageURL], ServiceError>) -> Void))
}

final class ImagesServiceImpl: ImagesService {

    // MARK: - Dependencies

    private let networkService: NetworkService
    private let serviceOptions = NetworkServiceOptions(baseURL: API.baseURL)

    // MARK: - Initializer

    init(with networkService: NetworkService) {
        self.networkService = networkService
    }

    // MARK: - Public Methods

    func getImages(completion: @escaping ((Result<[ImageURL], ServiceError>) -> Void)) {
        let request = ImagesRequest()

        networkService.executeRequest(request, serviceOptions: serviceOptions) { result in
            switch result {
            case .success(let imagesResponse):
                completion(.success(imagesResponse.images))
            case .failure(let error):
                completion(.failure(ServiceError.error(from: error)))
            }
        }
    }
    
}
